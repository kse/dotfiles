vim.filetype.add({
  extension = {
    templ = "templ",
  },
})

vim.api.nvim_create_autocmd("BufEnter",
  { pattern = "*.templ", callback = function() vim.cmd("TSBufEnable highlight") end })
