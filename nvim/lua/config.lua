--use {
--  "folke/todo-comments.nvim",
--  requires = "nvim-lua/plenary.nvim",
--  config = function()
--  end
--}

local ok, todo = pcall(require, "todo-comments")
if ok then
  todo.setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    --signs = false, -- don't show icons in the signs column
  }

  vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
  end, { desc = "Next todo comment" })

  vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
  end, { desc = "Previous todo comment" })
end
