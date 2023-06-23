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

" Vue
Plug 'posva/vim-vue'

" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" coc extensions
let g:coc_global_extensions = ['coc-tsserver', 'coc-html', 'coc-json', 'coc-css', 'coc-prettier', 'coc-eslint']

" JavaScript support
Plug 'pangloss/vim-javascript'
 " TypeScript syntax
Plug 'HerringtonDarkholme/yats.vim'
" GraphQL syntax
Plug 'jparise/vim-graphql'

" Initialize plugin system
call plug#end()

" coc.nvim CONFIG BEGIN
" --------------------------------------------------------

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

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
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
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
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

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

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" coc.nvim CONFIG BEGIN
" --------------------------------------------------------

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

