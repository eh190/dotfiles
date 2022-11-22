local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

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

lsp_installer.setup({})

lspconfig.tsserver.setup({
	on_attach = opts.on_attach,
})

lspconfig.eslint.setup({})

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

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
-- lsp_installer.on_server_ready(function(server)
--   if server.name == "jsonls" then
--     local jsonls_opts = require("user.lsp.settings.jsonls")
--     opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
--   end

--   if server.name == "sumneko_lua" then
--     local sumneko_opts = require("user.lsp.settings.sumneko_lua")
--     opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
--   end

--   if server.name == "pyright" then
--     local pyright_opts = require("user.lsp.settings.pyright")
--     opts = vim.tbl_deep_extend("force", pyright_opts, opts)
--   end

--[[ if server.name == "gopls" then ]]
--[[   local gopls_opts = require("user.lsp.settings.gopls") ]]
--[[   opts = vim.tbl_deep_extend("force", gopls_opts, opts) ]]
--[[ end ]]

-- This setup() function is exactly the same as lspconfig's setup function.
-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--   server:setup(opts)
-- end)
