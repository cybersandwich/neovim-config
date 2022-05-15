
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
Plug 'phaazon/hop.nvim'
"Plug 'gruvbox-community/gruvbox'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
"Plug 'vimwiki/vimwiki'
Plug 'ayu-theme/ayu-vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'renerocksai/telekasten.nvim'
Plug 'renerocksai/calendar-vim'
call plug#end()
set termguicolors     " enable true colors support
"let ayucolor="light"  " for light version of theme
let ayucolor="mirage" " for mirage version of theme
"let ayucolor="dark"   " for dark version of theme
colorscheme ayu
"colorscheme gruvbox
"highlight Normal guibg=none

let mapleader = " "

map <Tab> :bnext<CR>
map <S-Tab> :bprevious<CR>


nnoremap <leader>n :NERDTreeToggle<CR>
" END NERDTree

"let g:vimwiki_list = [{'path': '~/wknotes/'}]

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


let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='ayu'

"This lets you select a line and move it up or down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>bn :bn<cr>
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bk :bd<cr>
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
nnoremap <leader>pf :lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>pg :lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>pw :lua require('telescope.builtin').live_grep{search=vim.fn.expand("<cword>")}<cr>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>sc :lua require('telescope.builtin').spell_suggest()<cr>
nnoremap <leader>ll :lua require('zettle').test_grep_filename()<cr>
"au BufEnter to-do.wiki :! sh /Scripts/todo-vimwiki.sh
nnoremap <leader>tlr :! /bin/zsh -i  ~/projects/vim-todo/todo-vimwiki.sh<cr><cr>
nnoremap <leader>tl :e ~/wknotes/to-do.wiki<cr>

source ~/.config/nvim/lua/zettle.lua
source ~/.config/nvim/lua/lsp-stuff.lua
lua << END
local home = vim.fn.expand("$HOME/notes")
-- NOTE for Windows users:
-- - don't use Windows
-- - try WSL2 on Windows and pretend you're on Linux
-- - if you **must** use Windows, use "/Users/myname/zettelkasten" instead of "~/zettelkasten"
-- - NEVER use "C:\Users\myname" style paths
-- - Using `vim.fn.expand("~/zettelkasten")` should work now but mileage will vary with anything outside of finding and opening files
require('telekasten').setup({
    home         = home,

    -- if true, telekasten will be enabled when opening a note within the configured home
    take_over_my_home = true,

    -- auto-set telekasten filetype: if false, the telekasten filetype will not be used
    --                               and thus the telekasten syntax will not be loaded either
    auto_set_filetype = true,

    -- dir names for special notes (absolute path or subdir name)
    dailies      = home .. '/' .. 'daily',
    weeklies     = home .. '/' .. 'weekly',
    templates    = home .. '/' .. 'templates',

    -- image (sub)dir for pasting
    -- dir name (absolute path or subdir name)
    -- or nil if pasted images shouldn't go into a special subdir
    image_subdir = "img",

    -- markdown file extension
    extension    = ".md",

    -- prefix file with uuid
    prefix_title_by_uuid = false,
    -- file uuid type ("rand" or input for os.date()")
    uuid_type = "%Y%m%d%H%M",
    -- UUID separator
    uuid_sep = "-",

    -- following a link to a non-existing note will create it
    follow_creates_nonexisting = true,
    dailies_create_nonexisting = true,
    weeklies_create_nonexisting = true,

    -- skip telescope prompt for goto_today and goto_thisweek
    journal_auto_open = false,

    -- template for new notes (new_note, follow_link)
    -- set to `nil` or do not specify if you do not want a template
    template_new_note = home .. '/' .. 'templates/new_note.md',

    -- template for newly created daily notes (goto_today)
    -- set to `nil` or do not specify if you do not want a template
    template_new_daily = home .. '/' .. 'templates/daily.md',

    -- template for newly created weekly notes (goto_thisweek)
    -- set to `nil` or do not specify if you do not want a template
    template_new_weekly= home .. '/' .. 'templates/weekly.md',

    -- image link style
    -- wiki:     ![[image name]]
    -- markdown: ![](image_subdir/xxxxx.png)
    image_link_style = "markdown",

    -- default sort option: 'filename', 'modified'
    sort = "filename",

    -- integrate with calendar-vim
    plug_into_calendar = true,
    calendar_opts = {
        -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
        weeknm = 4,
        -- use monday as first day of week: 1 .. true, 0 .. false
        calendar_monday = 1,
        -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
        calendar_mark = 'left-fit',
    },

    -- telescope actions behavior
    close_after_yanking = false,
    insert_after_inserting = true,

    -- tag notation: '#tag', ':tag:', 'yaml-bare'
    tag_notation = "#tag",

    -- command palette theme: dropdown (window) or ivy (bottom panel)
    command_palette_theme = "ivy",

    -- tag list theme:
    -- get_cursor: small tag list at cursor; ivy and dropdown like above
    show_tags_theme = "ivy",

    -- when linking to a note in subdir/, create a [[subdir/title]] link
    -- instead of a [[title only]] link
    subdirs_in_links = true,

    -- template_handling
    -- What to do when creating a new note via `new_note()` or `follow_link()`
    -- to a non-existing note
    -- - prefer_new_note: use `new_note` template
    -- - smart: if day or week is detected in title, use daily / weekly templates (default)
    -- - always_ask: always ask before creating a note
    template_handling = "smart",

    -- path handling:
    --   this applies to:
    --     - new_note()
    --     - new_templated_note()
    --     - follow_link() to non-existing note
    --
    --   it does NOT apply to:
    --     - goto_today()
    --     - goto_thisweek()
    --
    --   Valid options:
    --     - smart: put daily-looking notes in daily, weekly-looking ones in weekly,
    --              all other ones in home, except for notes/with/subdirs/in/title.
    --              (default)
    --
    --     - prefer_home: put all notes in home except for goto_today(), goto_thisweek()
    --                    except for notes with subdirs/in/title.
    --
    --     - same_as_current: put all new notes in the dir of the current note if
    --                        present or else in home
    --                        except for notes/with/subdirs/in/title.
    new_note_location = "smart",

    -- should all links be updated when a file is renamed
    rename_update_links = true,
})
END
nnoremap <leader>zf :lua require('telekasten').find_notes()<CR>
nnoremap <leader>zd :lua require('telekasten').find_daily_notes()<CR>
nnoremap <leader>zg :lua require('telekasten').search_notes()<CR>
nnoremap <leader>zz :lua require('telekasten').follow_link()<CR>
nnoremap <leader>zC :CalendarT<CR>
nnoremap <leader>zt :lua require('telekasten').toggle_todo()<CR>
nnoremap <leader># :lua require('telekasten').show_tags()<CR>
lua require'hop'.setup()
map s <cmd>HopChar1<CR>
omap s <cmd>HopChar1<CR>
" on hesitation, bring up the panel
nnoremap <leader>z :lua require('telekasten').panel()<CR>
nnoremap <leader>zn :lua require('telekasten').new_note()<CR>
nnoremap <leader>[[ <cmd>:lua require('telekasten').insert_link()<CR>
"inoremap [[ <cmd>:lua require('telekasten').insert_link()<CR>
" just blue and gray links
"hi tkLink ctermfg=Blue cterm=bold,underline guifg=blue gui=bold,underline
"hi tkBrackets ctermfg=gray guifg=gray
" for gruvbox
hi tklink ctermfg=72 guifg=#689d6a cterm=bold,underline gui=bold,underline
hi tkBrackets ctermfg=gray guifg=gray
hi link CalNavi CalRuler
hi tkTagSep ctermfg=gray guifg=gray
hi tkTag ctermfg=175 guifg=#d3869B
