local lsp_zero = require('lsp-zero')
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

-- check if the cursor is at the end of a word.
-- This could mean that completion is possible.
-- Alternatively completion is not.
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local next_completion = function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  --elseif has_words_before() then
  --  cmp.complete()
  else
    fallback()
  end
end

local previous_completion = function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  --elseif has_words_before() then
  --  cmp.complete()
  else
    fallback()
  end
end

-- confirm_or_begin_completion will confirm the completion choice or open the
-- completion window.
local confirm_or_begin_completion = function(fallback)
  if cmp.visible() then
    cmp.confirm({
      -- BUG: I can't make this work properly. In certain cases it will replace
      -- the existing text.
      behavior = cmp.ConfirmBehavior.Insert,
      --behavior = cmp.ConfirmBehavior.Replace,

      select = false,
    })
  elseif has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = confirm_or_begin_completion,

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    ["<Tab>"] = cmp.mapping(next_completion, {"i", "s"}),
    ["<S-Tab>"] = cmp.mapping(previous_completion, { "i", "s" }),
  })
})

require('lspconfig').gopls.setup({
  preselect = cmp.PreselectMode.None
})

require('lspconfig').lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },

          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}

