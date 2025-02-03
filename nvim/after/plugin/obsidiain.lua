require('obsidian').setup {
  workspaces = {
    {
      name = "personal",
      path = "~/vault/personal",
    },
    {
      name = "Cardtokens",
      path = "~/vault/Cardtokens",
    },
  },

  mappings = {
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    ["gf"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    -- Toggle check-boxes.
    ["<leader>ch"] = {
      action = function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
    -- Smart action depending on context, either follow link or toggle checkbox.
    -- ["<cr>"] = {
    --   action = function()
    --     return require("obsidian").util.smart_action()
    --   end,
    --   opts = { buffer = true, expr = true },
    -- }
  },
  ui = {
    enable = false,
  },


  completion = {
    -- Set to false to disable completion.
    nvim_cmp = true,
    -- Trigger completion at 2 chars.
    min_chars = 2,
  },
}
