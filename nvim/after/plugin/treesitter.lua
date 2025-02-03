require "nvim-treesitter.configs".setup {
  diagnostics = { disable = { 'missing-fields' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      -- mappings for incremental selection (visual mappings)
      init_selection = "gnn",    -- maps in normal mode to init the node/scope selection
      node_incremental = "grn",  -- increment to the upper named parent
      scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
      node_decremental = "grm"   -- decrement to the previous node
    }
  },

  textobjects = {
    -- syntax-aware textobjects
    enable = true,
    lsp_interop = {
      enable = true,
      peek_definition_code = {
        ["<localleader>pf"] = "@function.outer",
      }
    },
    keymaps = {
      ["iL"] = {
        -- you can define your own textobjects directly here
        go = "(function_definition) @function",
      },
      -- or you use the queries from supported languages with textobjects.scm
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      --["aC"] = "@class.outer",
      --["iC"] = "@class.inner",
      --["ac"] = "@conditional.outer",
      --["ic"] = "@conditional.inner",
      ["ae"] = "@block.outer",
      ["ie"] = "@block.inner",
      ["al"] = "@loop.outer",
      ["il"] = "@loop.inner",
      ["is"] = "@statement.inner",
      ["as"] = "@statement.outer",
      ["ad"] = "@comment.outer",
      ["am"] = "@call.outer",
      ["im"] = "@call.inner"
    },
    move = {
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer"
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer"
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer"
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer"
      }
    },
    select = {
      enable = true,
      keymaps = {
        ["ic"] = "@custom_call.inner",
        ["ac"] = "@custom_call.outer",
        ["iv"] = "@custom_field_value",
        ["it"] = "@qualified_type"
      },
    },
    --    swap = {
    --      enable = enable,
    --      swap_next = {
    --        ["<leader>a"] = "@parameter.inner"
    --      },
    --      swap_previous = {
    --        ["<leader>A"] = "@parameter.inner"
    --      }
    --    }
  }
}
