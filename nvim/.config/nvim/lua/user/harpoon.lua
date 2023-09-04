local harpoon_status, harpoon = pcall(require, "harpoon")
if not harpoon_status then
	return
end

local mark_status_ok, mark = pcall(require, "harpoon.mark")
if not mark_status_ok then
	return
end

local ui_status_ok, ui = pcall(require, "harpoon.ui")
if not ui_status_ok then
	return
end

harpoon.setup({
	menu = {
		width = vim.api.nvim_win_get_width(0) - 60,
	},
})

vim.keymap.set("n", "<leader>ha", mark.add_file)
vim.keymap.set("n", "<leader>hm", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>hz", function()
	ui.nav_file(1)
end)
vim.keymap.set("n", "<leader>hx", function()
	ui.nav_file(2)
end)
vim.keymap.set("n", "<leader>hc", function()
	ui.nav_file(3)
end)
