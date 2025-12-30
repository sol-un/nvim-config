vim.api.nvim_create_autocmd('FocusLost', {
  desc = 'Fade on blur',
  group = vim.api.nvim_create_augroup('vimade_focus_fading', { clear = false }),
  callback = function()
    pcall(vim.cmd, 'VimadeEnable')
  end,
})

vim.api.nvim_create_autocmd('FocusGained', {
  desc = 'Unfade on start/focus',
  group = vim.api.nvim_create_augroup('vimade_focus_fading', { clear = false }),
  callback = function()
    pcall(vim.cmd, 'VimadeDisable')
  end,
})

-- Only use vimade to fade the entire editor when the window is blurred
return {
  {
    'TaDaa/vimade',
    event = 'FocusLost',
    opts = {
      recipe = { 'default', { animate = true } },
      enablefocusfading = true,
    },
  },
}
