-- LSP support built into neovim > v0.11.
-- Use nvim-lspconfig as a collection of LSP server configurations - can do it all manually if you want
-- By calling 'vim.lsp.enable('...')' neovim will use the default config provided by nvim-lspconfig.
-- Can override a config using 'vim.lsp.config('lsp_example', {...})'
-- Neovim will merge all default and manual configs together automatically

-- mason Docs https://github.com/williamboman/mason.nvim - package manager for LSPs
local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
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

-- Install these from mason (:Mason) on initial setup:
--     "clangd",
--     "cssls",
--     "gopls",
--     "html",
--     "jsonls",
--     "ts_ls",
--     "lua_ls",
--     "rust_analyzer",
--     "emmet_ls",
--     "dockerls",
--     "angularls",
--     "eslint",
--     "yamlls"

local opts = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}

vim.lsp.config("*", {
  capabilities = opts.capabilities,
  on_attach = opts.on_attach,
})

vim.lsp.enable("angularls")
vim.lsp.enable("cssls")
vim.lsp.enable("html")
vim.lsp.enable("emmet_ls")
vim.lsp.enable("dockerls")
vim.lsp.enable("eslint")
vim.lsp.enable("gopls")
vim.lsp.enable("ts_ls")

-- explicitly setting this up for clangd, otherwise it uses default on_attach
vim.lsp.config("clangd", {
	capabilities = opts.capabilities,
	on_attach = opts.on_attach,
  })
vim.lsp.enable("clangd")

-- explicitly setting this up for rust_analyzer, otherwise it uses default on_attach
vim.lsp.config("rust_analyzer", {
	capabilities = opts.capabilities,
	on_attach = opts.on_attach,
  })
vim.lsp.enable("rust_analyzer")

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})
vim.lsp.enable('lua_ls')

vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemas = {
        ['https://bitbucket.org/atlassianlabs/intellij-bitbucket-references-plugin/raw/master/src/main/resources/schemas/bitbucket-pipelines.schema.json'] =
        '*.yml'
      },
      format = {
        enable = true
      }
    }
  }
})
vim.lsp.enable('yamlls')

local jsonls_setup = require("user.lsp.settings.jsonls")
vim.lsp.config("jsonls", {
  settings = jsonls_setup.settings,
})
vim.lsp.enable('jsonls')

require("user.lsp.handlers").setup()
