vim.o.background = "dark" -- or "light" for light mode

-- Colorschemes that support the :lua vim.lsp.buf.document_highlight() (handlers.lua)
-- vim.cmd("colorscheme darkplus")
-- vim.cmd("colorscheme kanagawa")
-- vim.cmd("colorscheme kanagawa-lotus") -- light

vim.cmd('colorscheme rose-pine');

vim.cmd('hi DiffAdd blend=0 guifg=#252525 guibg=#587c0c')
vim.cmd('hi DiffChange blend=0 cterm=underline gui=underline guifg=#252525 guibg=#0c7d9d')
vim.cmd('hi DiffDelete blend=0 guifg=#252525 guibg=#94151b')
vim.cmd('hi DiffText blend=0 guifg=#252525 guibg=#94151b')
