--use {
--  "folke/todo-comments.nvim",
--  requires = "nvim-lua/plenary.nvim",
--  config = function()
--  end
--}

local ok, todo = pcall(require, "todo-comments")
if ok then
  todo.setup {
    signs = false,
  }

  vim.keymap.set("n", "]t", function()
    todo.jump_next()
  end, { desc = "Next todo comment" })

  vim.keymap.set("n", "[t", function()
    todo.jump_prev()
  end, { desc = "Previous todo comment" })

  vim.keymap.set("n", "<localleader>T", "<cmd>TodoTelescope<cr>", { desc = "Open Todo entries in Telescope" })
  vim.keymap.set("n", "<localleader>F", "<cmd>TodoTrouble keywords=FIXME<cr>",
    { desc = "Open Todo-Comments FIXME entries in Telescope" }
  )
end
