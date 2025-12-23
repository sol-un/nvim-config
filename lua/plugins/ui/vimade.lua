vim.api.nvim_create_autocmd('FocusLost', {
  desc = 'Fade on blur',
  group = vim.api.nvim_create_augroup('vimade_focus_fading', { clear = false }),
  callback = function()
    vim.cmd 'VimadeEnable'
  end,
})

vim.api.nvim_create_autocmd({ 'VimEnter', 'FocusGained' }, {
  desc = 'Unfade on start/focus',
  group = vim.api.nvim_create_augroup('vimade_focus_fading', { clear = false }),
  callback = function()
    vim.cmd 'VimadeDisable'
  end,
})

-- Only use vimade to fade the entire editor when the window is blurred
return {
  {
    'TaDaa/vimade',
    opts = {
      recipe = { 'default', { animate = true } },
      enablefocusfading = true,
    },
  },
}
