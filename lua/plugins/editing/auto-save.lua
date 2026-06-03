return {
  'okuuva/auto-save.nvim',
  opts = {
    trigger_events = {
      immediate_save = {},
      defer_save = { 'BufLeave', 'QuitPre', 'VimSuspend', 'FocusLost' },
    },
    debounce_delay = 100,
  },
}
