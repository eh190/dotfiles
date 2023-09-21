local buffer_manager_status, buffer_manager = pcall(require, "buffer_manager")
if not buffer_manager_status then
  return
end


buffer_manager.setup({
  width = 0.7,
})

local opts = { noremap = true }

-- Needs to be required after setup func
local ui_status, ui = pcall(require, "buffer_manager.ui")
if not ui_status then
  return
end

vim.keymap.set("n", "<leader>bm", ui.toggle_quick_menu, opts)
