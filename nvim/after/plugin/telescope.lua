local open_with_trouble = require("trouble.sources.telescope").open
local add_to_trouble = require("trouble.sources.telescope").add

require("telescope").setup {
  defaults = {
    selection_strategy = 'closest',
    mappings = {
      i = {
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
        ["<C-q>"] = open_with_trouble,
        --["<C-Q>"] = add_to_trouble,
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
vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
