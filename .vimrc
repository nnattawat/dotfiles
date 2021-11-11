set clipboard=unnamed
set nocompatible              " be iMproved, required

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'flazz/vim-colorschemes'

Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ddollar/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'

" Syntax validation
Plug 'scrooloose/syntastic'

" Plug 'ervandew/supertab'

" Highlight CSS color
Plug 'lilydjwg/colorizer'

Plug 'bronson/vim-trailing-whitespace'
Plug 'godlygeek/tabular'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-surround'

Plug 'Yggdroot/indentLine'

" React
" Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Initialize plugin system
call plug#end()

" Indentation
set expandtab
set tabstop=2
set shiftwidth=2
" showing special char
set listchars=tab:>-,trail:.,extends:>,precedes:<
" Display incomplete commands."
set showcmd
" Display the mode you're in.
set showmode
" Intuitive backspacing.
set backspace=indent,eol,start

syntax on

autocmd filetype crontab setlocal nobackup nowritebackup

set number
set relativenumber

set nowrap

" Open nerdtree
noremap <Leader>n :NERDTreeToggle<CR>
noremap <Leader>nf :NERDTreeFind<CR>
let NERDTreeShowHidden=1
" close vim if only open window is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

colorscheme Tomorrow-Night-Bright
highlight Comment ctermbg=none ctermfg=246

" Highlight cursor line
set cursorline

highlight ColorColumn ctermbg=235 guibg=#2c2d27
highlight LineNr ctermfg=40
highlight ExtraWhitespace ctermbg=235 guibg=#2c2d27
" highlight Normal ctermfg=252 ctermbg=black
" highlight StatusLine ctermbg=254 ctermfg=241
" highlight StatusLineNC ctermbg=248 ctermfg=236

"refresh all buffers
noremap <Leader>bu :bufdo e!<ENTER>
noremap <Leader>bd :bufdo<space>

" git fugitive
noremap <Leader>gst :Gstatus<ENTER>
noremap <Leader>gd :Gdiff<ENTER>
noremap <Leader>gb :Gblame<ENTER>
noremap <Leader>glg :Glog<ENTER>

" Menu for the buffers
noremap <F5> :buffers<CR>:

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

" let g:SuperTabCrMapping=1

"Setup ctags file
set tags=./tags;

"Disable arrow keys
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

"Show hidden file
let NERDTreeShowHidden=1
let g:ctrlp_show_hidden = 1

" CtrlP mapping
nmap <Leader>b :CtrlPBuffer<cr>
nmap <Leader>r :CtrlPMRU<cr>

"Ignore files -  CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|dist\|build\|coverage\|__pycache__\|.pytest_cache\|.webpack\|env\/lib'

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
" autocmd WinEnter    * set cursorline
" autocmd WinLeave    * set nocursorline
" autocmd InsertEnter * set nocursorline
" autocmd InsertLeave * set cursorline

" Navigate previous/next command lines using arrow match
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" default was 500
let g:gitgutter_max_signs = 700

" press 'r' in visual mode to replace current selection with yark in the registry
vmap r "_dP"

" new tab
noremap tn :tabnew<CR>
noremap td :tabclose<CR>

" Press Space to turn off highlighting and clear any message already displayed.
set hlsearch
:nnoremap <space> :nohlsearch<CR>

" Set statusline
set laststatus=2
set statusline=\ %f\ %m%r%h%w\ %=\ %c\ %p%%\ [%l\/%L]\ 

" prompt Ack
noremap <Leader>f :Ack<space><C-R><C-W><space>

" Move lines or blocks
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Tabularize key mapping
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>ac :Tabularize /:\zs<CR>
vmap <Leader>ac :Tabularize /:\zs<CR>
nmap <Leader>ap :Tabularize /\|<CR>
vmap <Leader>ap :Tabularize /\|<CR>

" Syntastic basic setup
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

" Map file commands with Shift
command! Wq wq
command! W w
command! Q q

" disable Esc in insert mode. Make it faster to switch to normal mode
set noesckeys

