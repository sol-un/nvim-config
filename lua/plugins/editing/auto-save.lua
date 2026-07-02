local excluded_filetypes = {
  'gitcommit',
}

return {
  'okuuva/auto-save.nvim',
  opts = {
    trigger_events = {
      immediate_save = {},
      defer_save = { 'BufLeave', 'QuitPre', 'VimSuspend', 'FocusLost' },
    },
    condition = function(buf)
      local ft = vim.fn.getbufvar(buf, '&filetype')
      return not vim.tbl_contains(excluded_filetypes, ft)
    end,
    debounce_delay = 100,
  },
}
