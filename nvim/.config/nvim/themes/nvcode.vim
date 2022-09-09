" configure nvcode-color-schemes
let g:nvcode_termcolors=256

syntax on
" colorscheme gruvbox " Or whatever colorscheme you make
colorscheme nvcode
" List of themes here
" https://github.com/ChristianChiarulli/nvcode-color-schemes.vim

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif
