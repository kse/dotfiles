local M = {}

M.repos = {
  -- Define custom test folder for a project
  --myproj = {
  --  test_root = "tests/src",
  --},
}

local repo_cache = {}
local repo_path_cache = {}

local function get_git_root()
  local cwd = vim.fn.getcwd()

  if repo_cache[cwd] then
    return repo_cache[cwd]
  end

  local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    return nil
  end

  repo_cache[cwd] = root
  return root
end

local function get_source_roots(repo, cfg)
  if cfg.source_roots and #cfg.source_roots > 0 then
    return cfg.source_roots
  end
  return { repo }
end

local function repo_name(git_root)
  return vim.fn.fnamemodify(git_root, ":t")
end

local function repo_relative(path, git_root)
  return path:gsub("^" .. vim.pesc(git_root) .. "/?", "")
end

local function strip_source_root(rel, source_roots)
  for _, root in ipairs(source_roots or {}) do
    root = root:gsub("/$", "")
    if rel:find("^" .. root .. "/") then
      return rel:gsub("^" .. root .. "/", "")
    end
  end
  return rel
end

local function get_test_root(git_root, repo, cfg)
  repo_path_cache[repo] = repo_path_cache[repo] or {}
  local cache = repo_path_cache[repo]

  if cache.test_root then
    return cache.test_root
  end

  local test_root

  if cfg.test_root then
    test_root = cfg.test_root:gsub("/$", "")
  elseif vim.fn.isdirectory(git_root .. "/tests") == 1 then
    test_root = "tests"
  else
    local source_root = get_source_roots(repo, cfg)[1]
    test_root = source_root .. "/tests"
  end

  cache.test_root = test_root

  -- 🔍 validation (warn once)
  local abs = git_root .. "/" .. test_root
  if vim.fn.isdirectory(abs) == 0 and not cache.test_root_warned then
    cache.test_root_warned = true
    vim.schedule(function()
      vim.notify(
        ("Test root does not exist:\n%s\n(Repo: %s)"):format(abs, repo),
        vim.log.levels.WARN
      )
    end)
  end

  return test_root
end

local function is_test_file(path, git_root)
  local repo = repo_name(git_root)
  local cfg = M.repos[repo] or {}
  local test_root = get_test_root(git_root, repo, cfg)
  if not cfg then
    return false
  end

  return path:find("^" .. vim.pesc(git_root .. "/" .. test_root))
      and vim.fn.fnamemodify(path, ":t"):match("^test_")
end

local function join_paths(...)
  local parts = {}
  for _, p in ipairs({ ... }) do
    if p and p ~= "" then
      table.insert(parts, p)
    end
  end
  return table.concat(parts, "/")
end

local function source_to_test(path, git_root)
  local repo = repo_name(git_root)
  local cfg = M.repos[repo] or {}
  if not cfg then
    return nil, "No repo config for " .. repo
  end

  local test_root = get_test_root(git_root, repo, cfg)
  local source_roots = get_source_roots(repo, cfg)

  local rel = repo_relative(path, git_root)
  rel = strip_source_root(rel, source_roots)



  local dir = vim.fn.fnamemodify(rel, ":h")
  if dir == "." then
    dir = ""
  end

  local base = vim.fn.fnamemodify(rel, ":t:r")

  local candidates = {}
  if base:sub(1, 1) == "_" then
    table.insert(candidates, "test_" .. base:sub(2) .. ".py")
    table.insert(candidates, "test_" .. base .. ".py")
  else
    table.insert(candidates, "test_" .. base .. ".py")
  end

  for _, name in ipairs(candidates) do
    local full = join_paths(git_root, test_root, dir, name)
    if vim.fn.filereadable(full) == 1 then
      return full
    end
  end

  return join_paths(git_root, test_root, dir, candidates[#candidates])
end

local function test_to_source(path, git_root)
  local repo = repo_name(git_root)
  local cfg = M.repos[repo] or {}
  if not cfg then
    return nil
  end
  local test_root = get_test_root(git_root, repo, cfg)
  local source_roots = get_source_roots(repo, cfg)

  local rel = repo_relative(path, git_root)
  rel = rel:gsub("^" .. vim.pesc(test_root) .. "/", "")

  local dir = vim.fn.fnamemodify(rel, ":h")
  if dir == "." then
    dir = ""
  end

  local base = vim.fn.fnamemodify(rel, ":t:r"):gsub("^test_", "")

  local candidates = {
    "_" .. base .. ".py",
    base .. ".py",
  }

  for _, root in ipairs(source_roots) do
    for _, name in ipairs(candidates) do
      local full = join_paths(git_root, root, dir, name)
      if vim.fn.filereadable(full) == 1 then
        return full
      end
    end
  end

  -- default creation path: first source root, private module
  local source_root = get_source_roots(repo, cfg)[1]
  return join_paths(git_root, source_root, dir, "_" .. base .. ".py")
end

function M.switch(opts)
  opts = opts or {}

  local git_root = get_git_root()
  if not git_root then
    vim.notify("Not in a git repository", vim.log.levels.ERROR)
    return
  end

  local current = vim.fn.expand("%:p")
  local target, err

  if is_test_file(current, git_root) then
    target = test_to_source(current, git_root)
  else
    target, err = source_to_test(current, git_root)
  end

  if not target then
    vim.notify(err or "Could not resolve target", vim.log.levels.ERROR)
    return
  end

  if vim.fn.filereadable(target) == 0 and not opts.create then
    vim.notify("File does not exist:\n" .. target, vim.log.levels.WARN)
    return
  end

  if opts.create then
    vim.fn.mkdir(vim.fn.fnamemodify(target, ":h"), "p")
  end

  vim.cmd("edit " .. vim.fn.fnameescape(target))
end

return M
