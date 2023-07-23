local mark_status_ok, mark = pcall(require, "harpoon.mark")
if not mark_status_ok then
	return
end

local ui_status_ok, ui = pcall(require, "harpoon.ui")
if not ui_status_ok then
	return
end

vim.keymap.set("n", "<leader>ha", mark.add_file)
vim.keymap.set("n", "<leader>hm", ui.toggle_quick_menu)

-- vim.keymap.set("n", "<C-a>", function()
-- 	ui.nav_file(1)
-- end)
-- vim.keymap.set("n", "<C-b>", function()
-- 	ui.nav_file(2)
-- end)
-- vim.keymap.set("n", "<C-c>", function()
-- 	ui.nav_file(3)
-- end)
