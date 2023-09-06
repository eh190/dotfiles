local status_ok, bufbar = pcall(require, "bufbar")
if not status_ok then
  return
end

bufbar.setup {
  theme = 'default',        -- the theme in 'lua/bufbar/themes' to use
  show_tabs = true,         -- show tabs
  show_bufname = 'current', -- show full buffer name ('current', 'visible' or 'all')
  show_flags = true,        -- show buffer flags
  show_alternate = false,   -- show alternate buffer
  modifier = ':t',          -- the name modifier
  term_modifier = ':t',     -- the name modifier for terminal buffers
  separator = '|',          -- the buffer separator
}
