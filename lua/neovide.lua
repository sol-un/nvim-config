if not vim.g.neovide then
  return {}
end

vim.opt.guifont = 'Lilex Nerd Font'
vim.g.snacks_scroll = false
vim.g.neovide_scale_factor = 0.8
vim.g.neovide_fullscreen = true

vim.cmd 'se mouse+=a'
vim.cmd 'noremap <C-C> "+y'
vim.cmd 'noremap <C-V> "+p'
vim.cmd 'cnoremap <C-V> <C-r>+'
vim.cmd 'imap <C-V> <C-r>+'

require('snacks').toggle
  .new({
    name = 'Fullscreen',
    get = function()
      return vim.g.neovide_fullscreen
    end,
    set = function()
      vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
    end,
  })
  :map '<Leader>Tf'
