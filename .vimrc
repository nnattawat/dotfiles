set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'kristijanhusak/vim-hybrid-material'

Plugin 'VundleVim/Vundle.vim'
Plugin 'mileszs/ack.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ddollar/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'
Plugin 'terryma/vim-multiple-cursors'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

Plugin 'bronson/vim-trailing-whitespace'
Plugin 'airblade/vim-gitgutter'
Plugin 'godlygeek/tabular'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'vim-scripts/ZoomWin'

" Indentation
set expandtab
set tabstop=2
set shiftwidth=2
" showing special char
set listchars=tab:>-,trail:.,extends:>,precedes:<

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

set nowrap

" Open nerdtree
noremap <Leader>n :NERDTreeToggle<CR>
noremap <Leader>nf :NERDTreeFind<CR>
let NERDTreeShowHidden=1
" close vim if only open window is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set background=dark
colorscheme hybrid_reverse
" highlight Comment ctermbg=none ctermfg=darkcyan
" highlight ColorColumn ctermbg=235 guibg=#2c2d27
highlight ExtraWhitespace ctermbg=235 guibg=#2c2d27
highlight Normal ctermfg=252 ctermbg=black
highlight StatusLine ctermbg=black ctermfg=7

"refresh all buffers
noremap <Leader>bu :bufdo e!<ENTER>
noremap <Leader>bd :bufdo<space>

" Menu for the buffers
noremap <F5> :buffers<CR>:buffer<space>

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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

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

" quick search
noremap <C-f> /<C-R><C-W>

" Syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

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

" copy/paste from clipboard
vnoremap cy "*y
noremap cp "*p
noremap c<S>p "*<S>p

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
:command Wq wq
:command W w
:command Q q

