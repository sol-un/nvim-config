require('lazy').setup({
  'NMAC427/guess-indent.nvim',
  { import = 'plugins' },
  { import = 'plugins.lang' },
  { import = 'plugins.git' },
  { import = 'plugins.mini' },
}, {
  checker = {
    enabled = true,
    notify = true,
  },
  install = { colorscheme = { 'tokyonight' } },
})

-- vim: ts=2 sts=2 sw=2 et
