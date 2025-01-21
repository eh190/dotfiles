vim.o.background = "light" -- or "light" for light mode

local function switch_theme()
    local curr_hour = tonumber(os.date("%H"))
    local curr_min = tonumber(os.date("%M"))
    -- print(curr_hour, curr_min)

    if curr_hour >= 9 and curr_hour < 17 then
        -- Day theme (light)
        vim.o.background = "light" -- or "light" for light mode
    else
        -- Night theme (dark)
        vim.o.background = "dark" -- or "light" for light mode
    end
end


local timer = vim.loop.new_timer()
timer:start(0, 3600, vim.schedule_wrap(function()
    switch_theme()
end))

-- Colorschemes that support the :lua vim.lsp.buf.document_highlight() (handlers.lua)
-- vim.cmd("colorscheme darkplus")
-- vim.cmd("colorscheme kanagawa")
-- vim.cmd("colorscheme kanagawa-lotus") -- light

-- vim.cmd('colorscheme rose-pine');

-- vim.cmd('hi DiffAdd blend=0 guifg=#252525 guibg=#587c0c')
-- vim.cmd('hi DiffChange blend=0 cterm=underline gui=underline guifg=#252525 guibg=#0c7d9d')
-- vim.cmd('hi DiffDelete blend=0 guifg=#252525 guibg=#94151b')
-- vim.cmd('hi DiffText blend=0 guifg=#252525 guibg=#94151b')

local status_ok, vscode = pcall(require, "vscode")
if not status_ok then
	return
end

local colors_status_ok, colors = pcall(require, "vscode.colors")
if not colors_status_ok then
	return
end

vscode.setup({})
-- local c = colors.get_colors()
-- vscode.setup({
--    -- Alternatively set style in setup
--     -- style = 'light'

--     -- Enable transparent background
    -- transparent = true,

--     -- Enable italic comment
--     italic_comments = true,

--     -- Underline `@markup.link.*` variants
--     underline_links = true,

--     -- Disable nvim-tree background color
--     disable_nvimtree_bg = true,

--     -- Override colors (see ./lua/vscode/colors.lua)
    -- color_overrides = {
    --     vscLineNumber = '#FFFFFF',
    -- },

--     -- Override highlight groups (see ./lua/vscode/theme.lua)
    -- group_overrides = {
--         -- this supports the same val table as vim.api.nvim_set_hl
--         -- use colors from this colorscheme by requiring vscode.colors!
    --     Cursor = { fg = c.vscCursorLight, bg = c.vscCursorLight},
    -- CursorLine ={ fg = c.vscCursorLight, bg = c.vscCursorLight} 
    -- }
-- })

vim.cmd('colorscheme vscode');
