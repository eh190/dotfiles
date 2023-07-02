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

local mason_null_ls_status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status_ok then
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
		"clangd",
		"cssls",
		"gopls",
		"html",
		"jsonls",
		"tsserver",
		"lua_ls",
		"rust_analyzer",
		"emmet_ls",
		"dockerls",
		"angularls",
	},
})

-- Passes formatters installed by Mason to null-ls for format on save
mason_null_ls.setup({
	ensure_installed = {
		"prettier",
		"stylua",
		-- "eslint_d",
		"gofumpt",
		"rustfmt",
		"clang-format",
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
local lua_ls_setup = require("user.lsp.settings.lua_ls")
local jsonl_setup = require("user.lsp.settings.jsonls")

lspconfig.angularls.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities })
lspconfig.cssls.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities })
lspconfig.html.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities })
lspconfig.emmet_ls.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities })
lspconfig.dockerls.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities })
lspconfig.rust_analyzer.setup({ on_attach = opts.on_attach, capabilities = opts.capabilities })

lspconfig.tsserver.setup({
	on_attach = opts.on_attach,
	capabilities = opts.capabilities,
	-- run lsp for javascript in any directory
	-- root_dir = function()
	-- 	return vim.loop.cwd()
	-- end,
})

lspconfig.jsonls.setup({
	on_attach = opts.on_attach,
	capabilities = opts.capabilities,
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
	capabilities = opts.capabilities,
	settings = gopls_setup.settings,
})

lspconfig.lua_ls.setup({
	on_attach = opts.on_attach,
	capabilities = opts.capabilities,
	settings = lua_ls_setup.settings,
})
