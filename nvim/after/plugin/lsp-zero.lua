require("neodev").setup({})

local lsp_zero = require('lsp-zero')
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({
    buffer = bufnr,
    exclude = { 'gr', 'gi' },
  })
  lsp_zero.buffer_autoformat()

  -- if client.supports_method("textDocument/formatting") then
  --   vim.keymap.set("n", "<Leader>f", function()
  --     vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
  --   end, { buffer = bufnr, desc = "[lsp] format" })
  -- end

  -- if client.supports_method("textDocument/rangeFormatting") then
  --   vim.keymap.set("x", "<Leader>f", function()
  --     vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
  --   end, { buffer = bufnr, desc = "[lsp] format" })
  -- end

  if client.supports_method("textDocument/typeDefinition") then
    vim.keymap.set("n", "gt", function()
      vim.lsp.buf.type_definition()
    end, { buffer = bufnr, desc = "[lsp] type definition" })
  end

  local telescope = require('telescope.builtin')
  if telescope then
    vim.keymap.set("n", "gi", function()
      telescope.lsp_implementations({
        jump_type = 'never',
        fname_width = 100,
        show_line = false,
      })
    end
    , {})

    vim.keymap.set("n", "gr", function()
      telescope.lsp_references({
        jump_type = 'never',
        fname_width = 100,
        show_line = false,
      })
    end, {})
  end
end)

--lsp_zero.format_on_save({
--  format_opts = {
--    async = false,
--    timeout_ms = 10000,
--  },
--  servers = {
--    ['gopls'] = {'go'},
--    ['rust_analyzer'] = {'rust'},
--    ['tsserver'] = {'javascript', 'typescript'},
--  }
--})

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
      -- Turns out this is a gopls error
      behavior = cmp.ConfirmBehavior.Replace,
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
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = confirm_or_begin_completion,

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    ["<Tab>"] = cmp.mapping(next_completion, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(previous_completion, { "i", "s" }),
  })
})

require('lspconfig').gopls.setup({
  settings = {
    -- https://github.com/golang/vscode-go/blob/33339e687f2034f80ae3018a79db121c8e04feed/docs/settings.md
    gopls = {
      hints = {
        assignVariableTypes = false,
        compositeLiteralFields = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = false,
        rangeVariableTypes = true,
      },
      experimentalPostfixCompletions = true,
      staticcheck = true,
      usePlaceholders = true,
      codelenses = {
        generate = false,   --// Don't show the `go generate` lens.
        gc_details = false, --// Show a code lens toggling the display of gc's choices.
        test = false,
      },
      analyses = {
        unusedparams = true,
        shadow = true,
        copylocks = true,
      },
    },
  },
})

require('lspconfig').lua_ls.setup {
  settings = {
    Lua = {
      -- Disable very noisy warning for missing fields.
      diagnostics = { disable = { 'missing-fields' } },
    }
  },
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          diagnostics = {
            globals = { "vim" },
          },
          hint = { enable = true },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            --library = {
            --  vim.env.VIMRUNTIME
            --},
            library = vim.api.nvim_get_runtime_file("", true),
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}

require('lspconfig').jsonls.setup({})
require('lspconfig').bufls.setup({})
require('lspconfig').bashls.setup({})
require('lspconfig').terraformls.setup({
  filetypes = { "terraform", "hcl", "terraform-vars" }
})
require('lspconfig').templ.setup({})
require('lspconfig').htmx.setup({})
require('lspconfig').html.setup({})
require('lspconfig').tailwindcss.setup({})


-- For JS config:
-- https://code.visualstudio.com/docs/languages/jsconfig
require('lspconfig').ts_ls.setup({})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

--require('lspconfig').terraform_lsp.setup({
--  filetypes = { "terraform", "hcl", "terraform-vars" }
--})


require('lspconfig').yamlls.setup {
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
      },
    },
  }
}
