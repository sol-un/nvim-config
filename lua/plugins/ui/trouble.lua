return {
  'folke/trouble.nvim',
  opts = {},
  keys = {
    { '<Leader>xX', '<Cmd>Trouble diagnostics toggle<CR>', desc = 'Trouble Workspace Diagnostics' },
    { '<Leader>xx', '<Cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Trouble Document Diagnostics' },
  },
}
