" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

if !has("gui_running")
	set t_Co=256
endif

set nocompatible
filetype off
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()

"Plugin 'VundleVim/Vundle.vim'
"
"Plugin 'neovim/nvim-lspconfig'
"Plugin 'hrsh7th/cmp-nvim-lsp'
"Plugin 'hrsh7th/cmp-buffer'
"Plugin 'hrsh7th/cmp-path'
"Plugin 'hrsh7th/cmp-cmdline'
"Plugin 'hrsh7th/nvim-cmp'
"
"Plugin 'simrat39/rust-tools.nvim'
"
"" Consider https://github.com/petertriho/cmp-git ?
"
"Plugin 'hrsh7th/cmp-vsnip'
"Plugin 'hrsh7th/vim-vsnip'
"
""Plugin 'dense-analysis/ale'
"
""Plugin 'peterrincker/vim-argumentative'
"
"Plugin 'ruanyl/vim-gh-line'
"
"Plugin 'ervandew/supertab'
""Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'scrooloose/nerdtree'
"Plugin 'airblade/vim-gitgutter'
"Plugin 'majutsushi/tagbar'
"
"Plugin 'rust-lang/rust.vim'
""Plugin 'fatih/vim-go'
"
"Plugin 'mbbill/undotree'
"
"Plugin 'savq/melange'
"
"" TODO: Setup and make work
""Plugin 'Chiel92/vim-autoformat'
"
"
""Plugin 'mechatroner/rainbow_csv'
"Plugin 'jpalardy/vim-slime'
"
""Plugin 'nvim-treesitter/nvim-treesitter'
"
""Plugin 'hashivim/vim-terraform'
"
""Plugin 'ekalinin/Dockerfile.vim'
"
""Plugin 'itchyny/lightline.vim'
"" Supports for ale in lightline
""Plugin 'maximbaz/lightline-ale'
"
"Plugin 'evanleck/vim-svelte'
"
"Plugin 'eandrju/cellular-automaton.nvim'
"
"" Oh Tim..
""Plugin 'tpope/vim-surround'
""Plugin 'tpope/vim-fugitive'
""Plugin 'tpope/vim-commentary'
""Plugin 'tpope/vim-repeat'
""Plugin 'tpope/vim-unimpaired'
""Plugin 'tpope/vim-abolish'
"Plugin 'flowtype/vim-flow', { 'do': 'npm install -g flow-bin' }
"
""Plugin 'folke/todo-comments.nvim'
""Plugin 'nvim-lua/plenary.nvim'
"call vundle#end()

filetype plugin indent on

if has("syntax")
  syntax on
endif

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  " Have Vim load indentation rules and plugins
  " according to the detected filetype.
  filetype plugin indent on
endif

if has("autocmd")
endif

" vim-autoformat
noremap <F3> :Autoformat<CR>

" Custom formatting for HTML files.
let g:formatdef_custom_html = '"html-beautify -A force-aligned -w 80 -n -f - -s ".&shiftwidth'
let g:formatters_html = ['custom_html']

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		    " Show (partial) command in status line.
set showmatch		" Show matching brackets.
"set autowrite		" Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned
set mouse=		    " Disable mouse usage
set hlsearch		" Enable search highlighting
set autoindent		" Enable automatic indentation
set foldmethod=manual
"set foldlevel=2
set noshowmode      " Let airline handle showing mode
set shortmess+=I
set undodir=~/.vim/undo               " For persistent undo
set undofile                          " Enable persistent undo
set updatetime=100                    " Trigger cursorhold faster
set laststatus=2
set ttimeoutlen=100

set sw=2
set ts=2
set expandtab
set scrolloff=3
set incsearch
set smartcase
set ruler

" Airline modifications
"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif

"let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#whitespace#mixed_indent_algo = 1
"let g:airline_theme='understated'
"let g:airline#extensions#tabline#fnamemod = ':t'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.whitespace = '≑'

set backspace=indent,eol,start

filetype on
filetype plugin on

nmap <silent> <leader>s :set nolist!<CR>

nnoremap ' `
nnoremap ` '

" Automatically add some boilerplate code when creating a new file.
if has("autocmd")
    augroup content
        autocmd!

        autocmd BufNewFile *.pl 0put ='# vim: set sw=4 sts=4 :' |
                    \ 0put ='#!/usr/bin/env perl' | set sw=4 sts=4  |
					\ 1put ='use warnings;' |
					\ 2put ='use strict;' |
                    \ norm G

        autocmd BufNewFile *.pm 0put ='package *' | set sw=4 sts=4  |
					\ 1put ='use warnings;' |
					\ 2put ='use strict;' |
					\ 3put ='' |
					\ 4put ='1;' |
					\ norm 1GA
    augroup END
endif

" Easypaste
"set pastetoggle=<F11>

"Make vim set the title of the window
set title

" Remap Tab to move between tabs
map <silent> <Tab> :tabnext<CR>
map <silent> <S-Tab> :tabprev<CR>
map <silent> <Leader><Tab> :+tabmove<CR>
map <silent> <Leader><S-Tab> :-tabmove<CR>

" Close the current tab, along with all the windows
map <silent> <C-w>C :tabclose<CR>

let g:C_Ctrl_j = 'off'
"Map C - hjkl to move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Indent/outdent visual selection and reselect
vnoremap < <gv
vnoremap > >gv

set termguicolors
let g:gruvbox_material_background = "hard"
"colorscheme gruvbox-material
colorscheme kanagawa-wave

let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 30
"map <F4> :TlistToggle<cr>

map <C-g>a ggVG

set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

set cc=82

"syn match ErrorLeadSpace /^ \+/      " highlight any leading spaces
"syn match ErrorTailSpace / \+$/      " highlight any trailing spaces
"syn match Error80        /\%>80v.\+/ " highlight anything past 80

"hi Error80 ctermbg=Red
"hi ErrorLeadSpace ctermbg=177
"hi ErrorTailSpace ctermbg=177

" Color reference: https://en.wikipedia.org/wiki/Xterm#Protocols
hi ColorColumn ctermbg=236 guibg=#2a2a2a

function! NumberToggle()
	let [&nu, &rnu] = [!&rnu, &nu+&rnu==1]
endfunc

nnoremap <silent> <C-m> :call NumberToggle()<cr>
set relativenumber
set number

" The quickfix and locationlist don't need relative numbers, for easy
" navigation.
au FileType qf setlocal norelativenumber colorcolumn=

let mapleader="-"

" Clear latest search
nnoremap <silent> <Leader>s :noh<CR>

nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :qall<CR>

nnoremap <Leader>h <C-w>h<CR>
nnoremap <Leader>j <C-w>jh<CR>
nnoremap <Leader>k <C-w>kh<CR>
nnoremap <Leader>l <C-w>lh<CR>
nnoremap <Leader>H <C-w>Hh<CR>
nnoremap <Leader>J <C-w>Jh<CR>
nnoremap <Leader>K <C-w>Kh<CR>
nnoremap <Leader>L <C-w>Lh<CR>

nnoremap <Leader>< 2<C-w><
nnoremap <Leader>> 2<C-w>>
nnoremap <Leader>, 2<C-w>-
nnoremap <Leader>. 2<C-w>+

nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt

nnoremap <silent> <Leader>u :UndotreeToggle<cr>

if filereadable(".vim.custom")
	so .vim.custom
endif

let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 0
let g:gitgutter_signs = 1
"let g:gitgutter_diff_args = '-w --word-diff=plain --histogram'
"let g:gitgutter_override_sign_column_highlight = 0


hi clear SignColumn
hi GitGutterAddLine guibg=#142814
hi GitGutterChangeLine guibg=#242414
hi GitGutterDeleteLine guibg=#421414

"if getcwd()~=#'^\(/home/kse/Code/cave/\)'
"	set secure exrc
"endif
"set secure exrc

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_custom_ignore = {
  \ 'file': '\.\(o\|d\|pdf\|blg\|bbl\|aux\|toc\)$',
  \ }


"let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_extra_conf_globlist = ['~/*']
let g:ycm_server_keep_logfiles = 1
let g:ycm_log_level = 'debug'

set wildignore+=*.class,*.swp,*.zip,*.jar

" Toggle Tagbar (https://github.com/majutsushi/tagbar) with F8
nmap <F8> :TagbarToggle<CR>

autocmd FileType tex :NoMatchParen
au FileType tex setlocal nocursorline

if has("gui_running")
	set guifont=Inconsolata\ 8
endif

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \  'right': [ [ 'lineinfo' ],
      \             [ 'percent' ],
      \             [ 'fileformat', 'fileencoding', 'filetype' ],
      \             [ 'linter_errors', 'linter_warnings', 'linter_ok' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

let g:lightline.component_type = {
        \   'linter_warnings': 'warning',
        \   'linter_errors': 'error',
        \   'linter_ok': 'left',
        \   'tabs': 'tabsel',
        \   'close': 'raw'
        \ }

"                               =============
"                               ==== ale ====
"                               =============

let g:ale_sign_column_always = 1
let g:ale_linters = {
      \ 'cs': ['csc', 'omnisharp'],
      \ 'ruby': ['rubocop'],
      \ 'terraform': ['terraform_ls']
			\}

let g:ale_linters_ignore = {
			\ 'go': ['staticcheck', 'golint', 'gofmt'],
      \}

let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \ 'terraform': ['terraform', 'trim_whitespace']
      \}

let g:lightline.component_expand = {
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"
let g:ale_set_loclist = 1

"nmap <silent> <C-j> <Plug>(ale_next_wrap)
"nmap <silent> <C-k> <Plug>(ale_previous_wrap)


highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
"autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"autocmd InsertLeave * match ExtraWhitespace /\s\+$/
"autocmd BufWinLeave * call clearmatches()

" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Disable ex mode
map Q <Nop>


" file is large from 10mb
let g:LargeFile = 1024 * 1024 * 5
augroup LargeFile
 autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function LargeFile()
 " no syntax highlighting etc
 set eventignore+=FileType
 " save memory when other file is viewed
 setlocal bufhidden=unload
 " is read-only (write with :w new_filename)
 setlocal buftype=nowrite
 " no undo possible
 setlocal undolevels=-1
 " display message
 autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction

"                           ==================
"                           ==== nerdtree ====
"                           ==================

map <silent> <C-n> :NvimTreeToggle<CR>
nmap <silent> <leader>nf :NvimTreeFindFile<cr>

"let g:NERDTreeDirArrowExpandable = '▸'
"let g:NERDTreeDirArrowCollapsible = '▾'
"let g:NERDTreeMinimalUI = 1
"let g:NERDTreeWinSize   = 42

"                           ======================
"                           ==== locationlist ====
"                           ======================

nmap <silent> <leader>lo :lopen<cr>
nmap <silent> <leader>ln :lnext<cr>
nmap <silent> <leader>lb :lbefore<cr>


"                              ================
"                              ==== vim-go ====
"                              ================

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

"autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
"autocmd FileType go nmap <Leader>i <Plug>(go-info)

let g:go_highlight_build_constraints = 1
let g:go_highlight_operators = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1

let g:go_decls_mode = 'ctrlp.vim'

let g:go_diagnostics_enabled = 1
let g:go_diagnostics_level = 2

let g:go_gopls_use_placeholders = 1
"let g:go_gopls_enabled = 0
let g:go_metalinter_command = "golangci-lint"
"let g:go_metalinter_autosave_enabled = ['vet', 'revive']

let g:go_debug_mappings = {
    \ '(go-debug-continue)': {'key': 'c', 'arguments': '<nowait>'},
    \ '(go-debug-next)': {'key': 'n', 'arguments': '<nowait>'},
    \ '(go-debug-step)': {'key': 's'},
    \ '(go-debug-print)': {'key': 'p'},
\ }

let g:go_doc_popup_window = 1

map <leader>ds :GoDebugStart<cr>
map <leader>dt :GoDebugStop<cr>
map <leader>db :GoDebugBreakpoint<cr>

let g:go_list_type = "quickfix"
let g:go_list_type_commands = {
  \ "GoLint": "quickfix", "GoMetaLinter": "quickfix", }


let g:go_fold_enable = ['block', 'import', 'varconst']

"                               ==============
"                               ==== Misc ====
"                               ==============

let g:slime_target = "tmux"
