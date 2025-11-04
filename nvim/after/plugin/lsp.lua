local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
  -- disable lsp watcher. Too slow on linux
  wf._watchfunc = function()
    return function() end
  end
end


--vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client == nil then
      return
    end

    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    --if client:supports_method('textDocument/completion') then
    --  -- Optional: trigger autocompletion on EVERY keypress. May be slow!
    --  -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
    --  -- client.server_capabilities.completionProvider.triggerCharacters = chars
    --  vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    --  --vim.lsp.completion.enable(false, client.id, args.buf, {})
    --end
  end,
})


local cmp = require('cmp')

-- check if the cursor is at the end of a word.
-- This could mean that completion is possible.
-- Alternatively completion is not.
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local next_completion = function(fallback)
  if cmp.visible() then
    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
    --elseif has_words_before() then
    --  cmp.complete()
    -- else
    --   fallback()
  end
end

local previous_completion = function(fallback)
  if cmp.visible() then
    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
    --elseif has_words_before() then
    --  cmp.complete()
    -- else
    --   fallback()
  end
end

-- confirm_or_begin_completion will confirm the completion choice or open the
-- completion window.
local confirm_or_begin_completion = function(fallback)
  if cmp.visible() then
    cmp.confirm({
      -- BUG: I can't make this work properly. In certain cases it will replace
      -- the existing text.
      -- Turns out this is a gopls error
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    })
  else
    --elseif has_words_before() then
    cmp.complete()
    --vim.lsp.completion.get()
    -- else
    --   fallback()
  end
end

cmp.setup({
  -- disable = true,
  --preselect = cmp.PreselectMode.None,
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({ select = true }),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = confirm_or_begin_completion,
    ['<Right>'] = confirm_or_begin_completion,

    -- Navigate between snippet placeholder
    -- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    -- ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    ["<Tab>"] = cmp.mapping(next_completion, { "i", "s" }),
    ["<Down>"] = cmp.mapping(next_completion, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(previous_completion, { "i", "s" }),
    ["<Up>"] = cmp.mapping(previous_completion, { "i", "s" }),
  })
})

-- vim.keymap.set("i", "<CR>", function()
--   if vim.fn.pumvisible() == 1 then
--     return "<C-y>" -- confirm the selection
--   else
--     return "<CR>"
--   end
-- end, { expr = true, noremap = true })
