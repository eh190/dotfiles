local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply logic to use different servers instead of null-ls here
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier, -- ts, js, json, markdown
		-- formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", { "--tab-width", 4 } } }),
		formatting.stylua, -- lua
		formatting.gofumpt, -- go
		formatting.rustfmt, -- rust
		formatting.clang_format, -- c
		-- diagnostics.eslint_d, -- eslint diagnostics
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					--[[ vim.lsp.buf.format({ bufnr = bufnr }) ]]
					-- on < 0.8 use	vim.lsp.buf.formatting_sync()
				end,
			})
		end
	end,
})
