local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Netrw
keymap("n", "<leader>e", ":Ex<CR>", opts) -- toggle netrw to pwd
keymap("n", "<leader>pv", ":Lex 30 %:p:h<CR>", opts) -- open netrw on current dir of open file. NOTE: pwd will not change
keymap("n", "<leader>%", ":e %:h/", opts) -- start creating a new file in same dir as open file. Just need to type new files name and return

-- Resize buffers with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -5<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +5<CR>", opts)

-- Buffers
keymap("n", "<leader>vs", ":vertical sbuffer<CR>", opts) -- open a vertical split of current buffer
keymap("n", "<leader>hs", ":sbuffer<CR>", opts) -- open a horizontal split of current buffer

-- Navigate Quickfix list
keymap("n", "]c", ":cnext<CR>", opts)
keymap("n", "[c", ":cprev<CR>", opts)

-- Save/ Load sessions
keymap("n", "<leader>ss", "<cmd>mks! ~/mysession.nvim<cr><cmd>echo 'current session saved'<cr>", opts) -- this will overwrite any exisitng session in the session file
keymap("n", "<leader>ls", "<cmd>source ~/mysession.nvim<cr><cmd>echo 'previous session loaded'<cr>", opts) -- loads the session from mysession file

-- Telescope
keymap("n", "<leader>pf", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>tlg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>tgs", "<cmd>Telescope git_status<cr>", opts)
keymap("n", "<leader>tr", "<cmd>Telescope lsp_references<cr>", opts)
keymap("n", "<leader>ts", "<cmd>Telescope git_stash<cr>", opts)
keymap("n", "<leader>tgh", "<cmd>Telescope git_bcommits<cr>", opts)
keymap("n", "<leader>tb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>tof", "<cmd>Telescope oldfiles<cr>", opts)

-- Format
-- see handlers.lua for definition of :Format cmd (uses lsp)
keymap("n", "<leader>fs", ":Format<cr><cmd>w<cr>", opts) -- Format and Save
keymap("n", "<leader>fp", "mt<cmd>%!npx prettier --stdin-filepath %<cr>'t", opts) -- requires prettier binary installed
keymap("n", "<leader>fc", "<cmd>%!clang-format --assume-filename=%<cr>", opts) -- requires clang-format binary installed
vim.keymap.set({"x", "v"}, "<leader>fp", ":'<,'>!npx prettier --stdin-filepath %<cr>", opts) -- format selection with prettier (needs to be complete block - it can't work out the context of just a few lines)
vim.keymap.set({"x", "v"}, "<leader>fs", "<cmd> lua vim.lsp.buf.format({async = true, range = {['start'] = vim.api.nvim_buf_get_mark(0, '<'),['end'] = vim.api.nvim_buf_get_mark(0, '>'),}})<cr><cmd>w<cr>", opts) -- Format and Save visual selection

-- Angular file switching
keymap("n", "<leader>oc", ":edit %<.ts<CR>", opts)
keymap("n", "<leader>ot", ":edit %<.html<CR>", opts)
keymap("n", "<leader>os", ":edit %<.scss<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts) -- prevents defualt copy/paste. Keeps copied item as copied item

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
