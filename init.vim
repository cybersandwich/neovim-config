
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set syntax=on

set guicursor=
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set nu
set wrap

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set colorcolumn=80
set signcolumn=yes
set magic
call plug#begin()
"Plug 'lervag/vimtex'
"Plug 'gruvbox-community/gruvbox'
"Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
"Plug 'nvim-telescope/telescope-fzy-native.nvim'
"Plug 'mbbill/undotree'
Plug 'vimwiki/vimwiki'
"Plug 'altercation/vim-colors-solarized'
"Plug 'arcticicestudio/nord-vim'
"Plug 'lifepillar/vim-solarized8'
Plug 'ayu-theme/ayu-vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
"-Plug 'kabouzeid/nvim-lspinstall'
"'Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
set termguicolors     " enable true colors support
"let ayucolor="light"  " for light version of theme
let ayucolor="mirage" " for mirage version of theme
"let ayucolor="dark"   " for dark version of theme
colorscheme ayu
"colorscheme gruvbox
"highlight Normal guibg=none

"set background=dark
"colorscheme solarized8_high
""let g:solarized_high
"
"let g:solarized8_termcolors=256

let mapleader = " "

map <Tab> :bnext<CR>
map <S-Tab> :bprevious<CR>


nnoremap <leader>n :NERDTreeToggle<CR>
" END NERDTree


let g:vimwiki_list = [{'path': '~/wknotes/'}]

" START NERDTree if no files are specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close NERDTree if it's the only window left open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"I found this on stackoverflow because the line above didn't work for me. This
"one works.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" https://github.com/nathanaelkane/vim-indent-guides/issues/20
let g:indent_guides_exclude_filetypes = ['nerdtree']

function! ToggleNERDTree()
  NERDTreeToggle
  silent NERDTreeMirror
endfunction


"let g:airline#themes#solarized#palette = {}
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='ayu'

"nnoremap <silent> <C-p> :Files<CR>
"nnoremap <silent> <C-f> :Rg<CR>
"nnoremap <silent> <C-b> :Buffers<CR>
  "
"T his lets you select a line and move it up or down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" greatest remap ever
"vnoremap <leader>p "_dP
noremap <leader>p "+p
"next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
vnoremap <leader>Y gg"+yG
"
nnoremap <leader>iv :e $HOME/.config/nvim/init.vim<cr>
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("grep for > ")})<cr>
"nnoremap <c-p> :lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>pf :lua require('telescope.builtin').find_files()<cr>

nnoremap <leader>pw :lua require('telescope.builtin').live_grep{search=vim.fn.expand("<cword>")}<cr>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<cr>

"au BufEnter to-do.wiki :! sh /Scripts/todo-vimwiki.sh
nnoremap <leader>tlr :! /bin/zsh -i  ~/wknotes/diary/todo.sh<cr><cr>
nnoremap <leader>tl :e ~/wknotes/to-do.wiki<cr>

source ~/.config/nvim/lua/*
