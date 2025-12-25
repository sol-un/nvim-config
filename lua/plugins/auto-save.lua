return {
  'okuuva/auto-save.nvim',
  opts = {
    trigger_events = {
      immediate_save = {},
      defer_save = { 'BufLeave', 'FocusLost', 'QuitPre', 'VimSuspend' },
    },
    debounce_delay = 100
  },
}
