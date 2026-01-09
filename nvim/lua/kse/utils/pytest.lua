local M = {}

function BuildNodeID()
  local file = vim.fn.expand("%:p")
  local root = vim.fn.getcwd()
  local rel = file:gsub("^" .. vim.pesc(root) .. "/", "")

  return rel
end

function Yank(nodeid)
  vim.fn.setreg('"', nodeid, "v") -- unnamed
  vim.fn.setreg("+", nodeid, "v") -- clipboard
  vim.fn.setreg("*", nodeid, "v") -- primary selection

  vim.notify("Yanked pytest nodeid: " .. nodeid)
end

function M.yank_class()
  -- Get the Treesitter node under cursor (modern API)
  vim.treesitter.get_parser():parse()
  local node = vim.treesitter.get_node({})
  if not node then
    vim.notify("No syntax node under cursor", vim.log.levels.WARN)
    return
  end

  -- Find nearest class_definition (optional)
  local class = node:parent()
  while class and class:type() ~= "class_definition" do
    class = class:parent()
  end

  if not class then
    vim.notify("Not inside a function", vim.log.levels.WARN)
    return
  end

  local class_name = nil
  local cname = class:field("name")[1]
  class_name = vim.treesitter.get_node_text(cname, 0)

  -- Build path
  local nodeid = BuildNodeID() .. "::" .. class_name

  Yank(nodeid)
end

function M.yank_method()
  ---------------------------------------------------------------------------
  -- Get the Treesitter node under cursor (modern API)
  ---------------------------------------------------------------------------
  vim.treesitter.get_parser():parse()
  local node = vim.treesitter.get_node({})
  if not node then
    vim.notify("No syntax node under cursor", vim.log.levels.WARN)
    return
  end

  ---------------------------------------------------------------------------
  -- Find the nearest function_definition
  ---------------------------------------------------------------------------
  local func = node
  while func and func:type() ~= "function_definition" do
    func = func:parent()
  end

  if not func then
    vim.notify("Not inside a function", vim.log.levels.WARN)
    return
  end

  local name_node = func:field("name")[1]
  local func_name = vim.treesitter.get_node_text(name_node, 0)

  ---------------------------------------------------------------------------
  -- Find nearest class_definition (optional)
  ---------------------------------------------------------------------------
  local class = func:parent()
  while class and class:type() ~= "class_definition" do
    class = class:parent()
  end

  local class_name = nil
  if class then
    local cname = class:field("name")[1]
    class_name = vim.treesitter.get_node_text(cname, 0)
  end

  ---------------------------------------------------------------------------
  -- Build pytest nodeid
  ---------------------------------------------------------------------------
  local nodeid = BuildNodeID()

  if class_name then
    nodeid = nodeid .. "::" .. class_name
  end
  nodeid = nodeid .. "::" .. func_name

  ---------------------------------------------------------------------------
  -- Yank to registers
  ---------------------------------------------------------------------------
  Yank(nodeid)
end

return M
