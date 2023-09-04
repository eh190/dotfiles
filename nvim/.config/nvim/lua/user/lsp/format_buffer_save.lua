local function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

local function has_value(tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

function Format_Buf(client, bufnr)
	-- if client.supports_method("textDocument/formatting") then
	-- vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	local filetype = vim.bo.filetype
	local pattern = ""
	local command = ""
	local prettier_filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"css",
		"scss",
		"less",
		"html",
		"json",
		"jsonc",
		"yaml",
		"markdown",
		"markdown.mdx",
		"graphql",
		"handlebars",
	}
	local clang_format_filetypes = {
		"c",
		"cpp",
		"cs",
		"java",
		"cuda",
		"proto",
	}
	local stylua_filetypes = { "lua", "luau" }

	-- %!npx prettier --stdin-filepath %
	local extension = vim.fn.expand("%:e")
	pattern = "*." .. extension

	if has_value(prettier_filetypes, filetype) then
		command = "%!prettier %"
	elseif has_value(clang_format_filetypes, filetype) then
		command = "%!clang-format %"
	elseif has_value(stylua_filetypes, filetype) then
		command = "%!stylua %"
	elseif filetype == "rust" then
		command = "%!rustfmt %"
	end

	-- Pattern is causing problems atm??????
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = augroup,
		pattern = pattern,
		-- command = command,
		buffer = bufnr,
		callback = function()
			print("wow we saved a file")
			vim.fn.jobstart(command)
			-- vim.lsp.buf.format({
			-- 	filter = function()
			-- 		-- apply logic to use different servers instead of null-ls here
			-- 		return client.name ~= "tsserver"
			-- 	end,
			-- 	bufnr = bufnr,
			-- })

			-- vim.lsp.buf.format()
			-- vim.lsp.buf.format({ bufnr = bufnr })
		end,
	})
	-- end
end
