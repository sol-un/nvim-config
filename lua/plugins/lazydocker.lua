return {
  'mgierada/lazydocker.nvim',
  dependencies = { 'akinsho/toggleterm.nvim' },
  cmd = 'Lazydocker',
  opts = {
    border = 'curved',
    width = 0.9,
    height = 0.9,
  },
  init = function()
    require('which-key').add {
      '<Leader>D',
      '<cmd>Lazydocker<cr>',
      desc = 'Lazydocker',
      icon = { icon = '󰡨', color = 'blue' },
    }
  end,
}
