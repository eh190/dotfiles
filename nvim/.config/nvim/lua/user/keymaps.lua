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
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Netrw
keymap("n", "<leader>e", ":Ex<CR>", opts) -- toggle netrw to pwd
keymap("n", "<leader>pv", ":Lex 30 %:p:h<CR>", opts) -- open netrw on current dir of open file. NOTE: pwd will not change
keymap("n", "<leader>%", ":e %:h/", opts) -- start creating a new file in same dir as open file. Just need to type new files name and return

-- Resize with arrows
keymap("n", "<leader>u", ":resize +2<CR>", opts)
keymap("n", "<leader>d", ":resize -2<CR>", opts)
keymap("n", "<leader>h", ":vertical resize -2<CR>", opts)
keymap("n", "<leader>l", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<C-q>", ":bdelete<CR>", opts)
keymap("n", "<leader>vs", ":vertical sbuffer<CR>", opts) -- open a vertical split of current buffer
keymap("n", "<leader>hs", ":sbuffer<CR>", opts) -- open a horizontal split of current buffer

-- Telescope
keymap("n", "<leader>pf", "<cmd>Telescope find_files<cr>", opts)
-- keymap("n", "<leader>ff", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<leader>tg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>ts", "<cmd>Telescope grep_string<cr>", opts)
keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts)
keymap("n", "<leader>gf", "<cmd>Telescope git_files<cr>", opts)

-- Format and save
-- see handlers.lua for definition of :Format cmd
keymap("n", "<leader>fs", ":Format<cr><cmd>w<cr>", opts)

-- ng (Angular) in ng.lua file

-- Gitsigns keymappings in the gitsigns.lua config file

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

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
