require("user.options")
require("user.keymaps")
require("user.plugins")
require("user.colorscheme")
require("user.cmp")
require("user.lsp")
require("user.telescope")
require("user.harpoon")
require("user.treesitter")
require("user.autopairs")
require("user.comment")
require("user.bufferline")
require("user.gitsigns")

-- local group = vim.api.nvim_create_augroup("Smash", { clear = true })

-- local attach_to_buffer = function(output_bufnr, pattern, command)
-- 	print(output_bufnr, pattern)
-- 	vim.api.nvim_create_autocmd("BufWritePre", {
-- 		pattern = pattern,
-- 		group = group,
-- 		callback = function()
-- 			print("wow we saved a file")
-- 			-- vim.lsp.buf.format()
-- 			vim.lsp.buf.format({ bufnr = bufnr })
-- 		end,
-- 	})
-- end

-- vim.api.nvim_create_user_command("AutoRun", function()
-- 	print("Auto run starts now")
-- 	attach_to_buffer(vim.api.nvim_get_current_buf(), "*.lua", {})
-- end, {})
