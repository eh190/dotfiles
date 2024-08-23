local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end

local context_status_ok, ts_context_comment = pcall(require, "ts_context_commentstring")
if not context_status_ok then
	return
end

comment.setup({
	-- ignore empty lines
	ignore = "^$",
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})

ts_context_comment.setup({
	enable = true,
	enable_autocmd = false,
})


