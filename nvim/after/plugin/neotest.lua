-- require("neotest").setup({
--   adapters = {
--     require("neotest-go"),
--   },
-- })

-- get neotest namespace (api call creates or returns namespace)
local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      local message =
          diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
      return message
    end,
  },
}, neotest_ns)

require("neotest").setup({
  -- your neotest config here
  adapters = {
    require("neotest-go"),
  },
  status = {
    enabled = true,
    signs = true,
    virtual_text = false,
  },
})
