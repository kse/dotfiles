-- THIS FILE IS DEPRECATED AS I HAVE MOVED ON TO lsp-zero --


local servers = {'solargraph', 'gopls', 'terraformls', 'bashls', 'rust_analyzer'}
--local servers = {'solargraph', 'terraformls', 'bashls', 'rust_analyzer'}

-- Setup nvim-cmp.
local cmp = require('cmp')

require('rust-tools').setup({})

-- Setup lspconfig.
local nvim_lsp = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local next_completion = function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif vim.fn["vsnip#available"](1) == 1 then
    feedkey("<Plug>(vsnip-expand-or-jump)", "")
  elseif has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end

local previous_completion = function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif vim.fn["vsnip#jumpable"](-1) == 1 then
    feedkey("<Plug>(vsnip-jump-prev)", "")
  elseif has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end

cmp.setup({
  completion = {
    completeopt = 'menu,menuone,noselect',
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-Space>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(next_completion, {"i", "s"}),
    ["<S-Tab>"] = cmp.mapping(previous_completion, { "i", "s" }),
    ["<C-n>"] = cmp.mapping(next_completion, {"i", "s"}),
    ["<C-p>"] = cmp.mapping(previous_completion, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  }),
  settings = {
    gopls = {
      -- https://github.com/golang/vscode-go/blob/33339e687f2034f80ae3018a79db121c8e04feed/docs/settings.md
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
        copylocks = false,
      },
      staticcheck = false,
      lintTool = "golangci-lint"
    },
  },
})

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 100,
    },
    cmd = {'gopls', '-debug=:0', '-v'},
    settings = {
      gopls = {
        -- https://github.com/golang/vscode-go/blob/33339e687f2034f80ae3018a79db121c8e04feed/docs/settings.md
        experimentalPostfixCompletions = true,
        analyses = {
          unusedparams = true,
          shadow = true,
          copylocks = false,
        },
        staticcheck = true,
        hints = {
          assignVariableTypes = true,
        },
      },
    lintTool = 'golangci-lint',
    },
  }
end

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
}
