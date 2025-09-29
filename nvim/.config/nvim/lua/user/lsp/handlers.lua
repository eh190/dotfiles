local M = {}

M.setup = function()
  local config = {
    virtual_text = true, -- enable virtual text for errors and warnings inline
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.INFO] = "",
      }
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
  }

  vim.diagnostic.config(config)
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function lsp_keymaps()
  local opts = { noremap = true, silent = true }
  local keymap = vim.keymap.set
  keymap("n", "gd", vim.lsp.buf.definition, opts)
  keymap("n", "K", vim.lsp.buf.hover, opts)
  keymap("n", "gr", vim.lsp.buf.references, opts)
  keymap("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  keymap("n", "<leader>vrn", vim.lsp.buf.rename, opts)
  keymap("n", "<leader>vd", vim.diagnostic.open_float, opts)
  --vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
--	vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
--   keymap("n", "[d", vim.diagnostic.jump({ count = 1, float = true }), opts)
--   keymap("n", "]d", vim.diagnostic.jump({ count = -1, float = true }), opts)
  keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  keymap("n", "gi", vim.lsp.buf.implementation, opts)
  keymap("n", "gD", vim.lsp.buf.declaration, opts)
  keymap("n", "<leader>q", vim.diagnostic.setloclist, opts)
end

M.on_attach = function(client, bufnr)
  lsp_keymaps()
  lsp_highlight_document(client)
  if client.name == "yamlls" then
    client.server_capabilities.documentFormattingProvider = true
  end
end

local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.default_capabilities()

return M
