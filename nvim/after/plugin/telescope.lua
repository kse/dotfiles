require("telescope").setup {
  defaults = {
    selection_strategy = 'closest',
    mappings = {
      i = {
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
      },
    },
    symbol_width = 60,
  },
  pickers = {
    git_files = {
      show_untracked = true,
    },
    lsp_document_symbols = {
      --symbol_width = 60,
    },
  }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
