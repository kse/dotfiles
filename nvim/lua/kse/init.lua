-- Temporary
--require('kse.packer')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- require("lazy").setup('kse.packages')

require("lazy").setup({
  {import = 'kse.plugins'},
})

--require('kse.completion')
require('kse.keymaps')
require('kse.ft')
