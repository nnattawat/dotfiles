set clipboard=unnamed
set nocompatible              " be iMproved, required

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'flazz/vim-colorschemes'

Plug 'VundleVim/Vundle.vim'
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ddollar/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/syntastic'
Plug 'terryma/vim-multiple-cursors'

" Plug 'ervandew/supertab'

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'bronson/vim-trailing-whitespace'
Plug 'godlygeek/tabular'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-surround'

Plug 'Yggdroot/indentLine'

" Running test
Plug 'janko/vim-test'
Plug 'tpope/vim-dispatch'

" React
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Jekyll
Plug 'tpope/vim-liquid'

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

set nowrap

" Open nerdtree
noremap <Leader>n :NERDTreeToggle<CR>
noremap <Leader>nf :NERDTreeFind<CR>
let NERDTreeShowHidden=1
" close vim if only open window is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set background=dark
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

let g:SuperTabCrMapping=1

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
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|dist'

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

" RSpec.vim mappings
map <Leader>sf :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>sl :call RunLastSpec()<CR>
map <Leader>sa :call RunAllSpecs()<CR>
" let g:rspec_command = "!rspec {spec}"
let g:rspec_command = "Dispatch bundle exec rspec {spec}"

" coc.nvim CONFIG BEGIN
" --------------------------------------------------------
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>=  <Plug>(coc-format-selected)
nmap <leader>=  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" --------------------------------------------------------
" coc.nvim CONFIG END
