vim.g.mapleader = '-'
vim.g.maplocalleader = ' '

require('kse')
require('config')

-- Source legacy VIM config
vim.cmd('source ~/.config/nvim/config.vim')

-- Old .vim source
-- set runtimepath^=~/.vim runtimepath+=~/.vim/after
-- let &packpath = &runtimepath
-- 
-- source ~/.config/nvim/vimrc
-- "source ./scripts.vim
-- source ~/.config/nvim/completion.vim
-- 
-- :lua require('config')
