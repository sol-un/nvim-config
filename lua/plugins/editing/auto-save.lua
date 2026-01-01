return {
  'okuuva/auto-save.nvim',
  opts = {
    trigger_events = {
      immediate_save = {},
      -- TODO:
      -- Should also enable 'FocusLost', but it messes with markdown files when swiching language.
      -- Adjus options dynamically in markdown lang settings
      defer_save = { 'BufLeave', 'QuitPre', 'VimSuspend' },
    },
    debounce_delay = 100,
  },
}
