set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'mileszs/ack.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ddollar/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'
Plugin 'terryma/vim-multiple-cursors'

" Indentation
set expandtab
set tabstop=2
set shiftwidth=2

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this lineyntax on

syntax on

autocmd filetype crontab setlocal nobackup nowritebackup

set number

" Open nerdtree
map <Leader>n :NERDTreeToggle<CR>
map <C-n> :NERDTreeFind<CR>
let NERDTreeShowHidden=1
" close vim if only open window is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" colorscheme Tomorrow-Night-Bright
" colorscheme vividchalk
:highlight Comment ctermbg=none ctermfg=darkcyan
:highlight ColorColumn ctermbg=235 guibg=#2c2d27


"refresh all buffers
noremap <Leader>u :bufdo e!<ENTER>

noremap <Leader>B :bufdo<space>

"Setup code folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

"Set key waiting time
set timeoutlen=200

"Set the column length
" let &colorcolumn="100"
let &colorcolumn="100,".join(range(200,999),",")

"Set autocomplete for Vim commands
set wildmenu

"Highlight matched word
let g:ackhighlight = 1

let g:SuperTabCrMapping=1

"Setup ctags file
set tags=./tags;

"Ignore warning on angular directive
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

"Disable arrow keys
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

"Show hidden file
let NERDTreeShowHidden=1
let g:ctrlp_show_hidden = 1

"Ignore files -  CtrlP
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip
"unlet g:ctrlp_custom_ignore
"let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

"Add extra space on comment line
let NERDSpaceDelims=0

" move cursor to last position when open files
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif"`'")"'")

" Enable matchit
if !exists('g:loaded_matchit')
  runtime macros/matchit.vim
endif

" disable cursor line one insert mode
autocmd WinEnter    * set cursorline
autocmd WinLeave    * set nocursorline
autocmd InsertEnter * set nocursorline
autocmd InsertLeave * set cursorline

" Navigate previous/next command lines using arrow match
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" default was 500
let g:gitgutter_max_signs = 700

" press 'r' in visual mode to replace current selection with yark in the registry
vmap r "_dP"

" new tab
noremap tn :tabnew<CR>
" disable cursor line one insert mode
noremap td :tabclose<CR>
