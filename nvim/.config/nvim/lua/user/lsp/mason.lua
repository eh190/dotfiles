-- mason Docs https://github.com/williamboman/mason.nvim
-- mason-lspconfig docs https://github.com/williamboman/mason-lspconfig.nvim
-- Migrating to mason from old nvim-lsp-installer https://github.com/williamboman/nvim-lsp-installer/discussions/876
local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
	return
end

local mason_lsp_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lsp_status_ok then
	return
end

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- Add language servers here. Auto install on vim start if not already. Maps to 'mason' language servers (:Mason to see mason LS's)
-- Once installed, call setup() on that LS (following pattern below). Can pass opts to LS if we want to override default config
mason_lspconfig.setup({
	ensure_installed = {
		"cssls",
		"eslint",
		"gopls",
		"html",
		"jsonls",
		"tsserver",
		"sumneko_lua",
		"rust_analyzer",
		"emmet_ls",
	},
})

local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_status_ok then
	return
end

local opts = {
	on_attach = require("user.lsp.handlers").on_attach,
	capabilities = require("user.lsp.handlers").capabilities,
}

local gopls_setup = require("user.lsp.settings.gopls")
local sumneko_lua_setup = require("user.lsp.settings.sumneko_lua")
local jsonl_setup = require("user.lsp.settings.jsonls")

lspconfig.eslint.setup({})
lspconfig.cssls.setup({})
lspconfig.html.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.emmet_ls.setup({})

lspconfig.tsserver.setup({
	on_attach = opts.on_attach,
	-- run lsp for javascript in any directory
	-- root_dir = function() 
	-- 	return vim.loop.cwd() 
	-- end,  
})

lspconfig.jsonls.setup({
	on_attach = opts.on_attach,
	settings = jsonl_setup.settings,
	commands = {
		Format = {
			function()
				vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
			end,
		},
	},
})

lspconfig.gopls.setup({
	on_attach = opts.on_attach,
	settings = gopls_setup.settings,
})

lspconfig.sumneko_lua.setup({
	on_attach = opts.on_attach,
	settings = sumneko_lua_setup.settings,
})
