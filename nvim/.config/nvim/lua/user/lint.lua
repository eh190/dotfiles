local status_ok, lint = pcall(require, "lint")
if not status_ok then
	return
end

lint.linters_by_ft = {
  typescript = { 'eslint_d' },
  javascript = { 'eslint_d' },
  javascriptreact = { 'eslint_d' },
  typescriptreact = { 'eslint_d' }
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  pattern = { "*.ts", "*.js" },
  callback = function()
    lint.try_lint()
  end,
})

