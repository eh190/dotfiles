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

local status_ok, vscode = pcall(require, "vscode")
if not status_ok then
	return
end

local colors_status_ok, colors = pcall(require, "vscode.colors")
if not colors_status_ok then
	return
end

vscode.setup({})
vim.cmd('colorscheme vscode');
