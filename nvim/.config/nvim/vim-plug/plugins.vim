call plug#begin('~/.config/nvim/autoload/plugged')
" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" NVIM Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Comments
Plug 'tpope/vim-commentary'

" Themes
Plug 'morhetz/gruvbox'
Plug 'christianchiarulli/nvcode-color-schemes.vim'

" Linting/prettier
Plug 'dense-analysis/ale'

" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Git
Plug 'tpope/vim-fugitive'

" Status Bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'

" follow file imports. <c-w>gf to open in new split when cursor over file
" Plug 'PsychoLlama/further.vim'

" Automatically shows vim complete menu when typing
" Plug 'vim-scripts/AutoComplPop'

" Better Syntax Support
Plug 'sheerun/vim-polyglot'

 Plug 'cohama/lexima.vim'
" Auto pairs for '(' '[' '{'
"Plug 'jiangmiao/auto-pairs'

call plug#end()
