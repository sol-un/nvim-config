return {
  'folke/trouble.nvim',
  --- @module 'trouble'
  --- @type trouble.Config
  --- @diagnostic disable: missing-fields
  opts = {},
  keys = {
    { '<Leader>xX', '<Cmd>Trouble diagnostics toggle<CR>', desc = 'Trouble Workspace Diagnostics' },
    { '<Leader>xx', '<Cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Trouble Document Diagnostics' },
  },
}
