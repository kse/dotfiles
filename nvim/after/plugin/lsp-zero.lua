vim.lsp.config('gopls', {
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

vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
          path ~= vim.fn.stdpath('config')
          and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths
          -- here.
          -- '${3rd}/luv/library'
          -- '${3rd}/busted/library'
        }
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        -- }
      }
    })
  end,
  settings = {
    Lua = {
      -- Disable very noisy warning for missing fields.
      diagnostics = { disable = { 'missing-fields' } },
    }
  },
})


vim.lsp.config('jsonls', {})
vim.lsp.config('bashls', {})
vim.lsp.config('terraformls', {
  filetypes = { "terraform", "hcl", "terraform-vars" }
})

-- vim.lsp.config('templ', {})
-- vim.lsp.config('htmx', {})

vim.lsp.config('html', {})
vim.lsp.config('tailwindcss', {})


-- For JS config:
-- https://code.visualstudio.com/docs/languages/jsconfig
vim.lsp.config('ts_ls', {})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

--vim.lsp.config('terraform_lsp', {
--  filetypes = { "terraform", "hcl", "terraform-vars" }
--})


vim.lsp.config('yamlls', {
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
      },
    },
  }
})

--require('lspconfig').pyright.setup {
--  settings = {
--    pyright = {
--      openFilesOnly = true
--    },
--    python = {
--      path = os.getenv("PYENV_VIRTUAL_ENV"), -- to make pyright work
--      analysis = {
--        typeCheckingMode = "standard",
--        autoImportCompletions = true,
--        useLibraryCodeForTypes = true,
--        diagnosticMode = "openFilesOnly",
--        stubPath = "",
--        diagnosticSeverityOverrides = {
--          reportUnusedImport = "information",
--          reportAssignmentType = "none",
--          reportMissingTypeStubs = false,
--          reportIncompatibleMethodOverride = "information",
--          reportIncompatibleVariableOverride = false,
--        }
--      }
--    }
--  }
--}

vim.lsp.config('ruff', {
  init_options = {
    settings = {
      lint = {
        select = { "A", "C4", "DTZ", "EM", "EXE", "PIE", "PT", "Q", "RET", "SIM", "TD", "TC", "E", "W", "F", "B", "RUF", "C90", "UP", "PERF", "PL", "FURB" },
        ignore = {
          -- Pyright duplicates:
          "F841", -- reportUnusedVariable
          "F401", -- reportUnusedImport
          -- Unused 'from ... import *'
          "F405",
          -- Redefined name from outer scope
          "F811",
          -- Ambiguous variable name ('l', 'O', or 'I')
          "E741",
          -- 'from ... import *' used
          "F403",
          -- Undefined name from __all__
          "F822",
          -- Module level import not at top of file
          "E402",
          -- Line too long (> 88 characters)
          "E501",
          -- Variable in `for` loop is not a valid `async for` target
          "RUF007",
          -- Too many branches, too simple.
          "PLR0912",
          -- Too many statements. This is too simple.
          "PLR0915",
          "EM101",
          "EM102",
          -- Magic constants, this triggers too often and is simplistic
          "PLR2004",
          -- Shadowing input builtin, so you can't use e.g. input as an arg
          "A002",
          "RET505",
          -- Pytest
          "PT003", -- scope=function on fixture warning
        },
      },
      configuration = {
        lint = {
          mccabe = {
            ["max-complexity"] = 10,
          },
          pylint = {
            ["max-returns"] = 10,
          }
        },
      },

    }
  }
})

-- https://neovim.io/doc/user/lsp.html#lsp-attach
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client == nil then
      return
    end

    -- Disable hover capability from Ruff in favor our basedpyright
    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
})

vim.lsp.config('basedpyright', {
  settings = {
    basedpyright = {
      openFilesOnly = true,
      disableOrganizeImports = false,
      analysis = {
        typeCheckingMode = "standard",
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
        -- stubPath = "",
        diagnosticSeverityOverrides = {
          reportUnnecessaryTypeIgnoreComment = "information",
          reportUnusedImport = "information",
          reportAssignmentType = "none",
          reportMissingTypeStubs = false,
          reportIncompatibleMethodOverride = "information",
          reportIncompatibleVariableOverride = false,
          reportCallInDefaultInitializer = "warning",
          reportUntypedFunctionDecorator = "information",
          reportUntypedClassDecorator = "information",
        }
      },
      inlayHints = {
        callArgumentNames = true,
        genericTypes = true,
      }
    },
    python = {
      path = os.getenv("PYENV_VIRTUAL_ENV"), -- to make pyright work
    }
  }
})

vim.lsp.config('docker_compose_language_service', {})

vim.lsp.enable({
  'gopls',
  'lua_ls',
  'jsonls',
  'bashls',
  'terraformls',
  'html',
  'tailwindcss',
  'ts_ls',
  'yamlls',
  'docker_compose_language_service',

  'basedpyright',
  'ruff',
  'nushell',
})
