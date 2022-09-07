"==== General Settings ====
set re=0                    "means vim can load highlighting in files (with ts) without freezing
set scrolloff=8             "begin scroll x spaces from bottom
set number                  "numbers are good
set relativenumber          "rel numbers are really good
set tabstop=4 softtabstop=4 "tab amounts
set shiftwidth=2            "shift amount
set expandtab
filetype indent on
set smartindent
set autoread 
set complete+=kspell        "spell check options on autocomplete <C-p>
set completeopt=menuone,longest,preview "options for autocomplete
set shortmess+=c            "status bar doesn't show 1/n options 

"==== Plugins ====

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')
" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Themes
Plug 'morhetz/gruvbox'

" Bracket Pairs
Plug 'frazrepo/vim-rainbow'

" Linting/prettier
Plug 'dense-analysis/ale'

" Git
Plug 'tpope/vim-fugitive'

" Status Bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" follow file imports. <c-w>gf to open in new split when cursor over file
Plug 'PsychoLlama/further.vim'

" Automatically shows vim complete menu when typing
Plug 'vim-scripts/AutoComplPop'
call plug#end()

set termguicolors     " enable true colors support
autocmd vimenter * ++nested colorscheme gruvbox

let g:rainbow_active = 1

" linting
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\}
"let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'

" Netrw
let g:netrw_liststyle = 3
" let g:netrw_winsize = 80       "sets percentage width of any subsequent buffers openes from first 
" let g:netrw_browse_split = 4   
" let g:netrw_preview = 1

" Vim Airline
let g:airline#extensions#tabline#enabled = 1 "shows open buffers as tabs
let g:airline_theme='simple'

"further
let g:further#extensions = ['.ts']

" REMAPS
let mapleader = " "
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader><CR> :so ~/.vimrc<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <leader>rp :resize 100<CR>
nnoremap <leader>+ :vertical resize +25<CR>
nnoremap <leader>- :vertical resize -5<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bv :bp<CR>
nmap <silent> <C-e> <Plug>(ale_next_wrap)
