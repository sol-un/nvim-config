local toggle = require('snacks').toggle

require('which-key').add { { '<Leader>T', group = 'Toggles' } }
toggle.option('wrap', { name = 'Wrap' }):map '<Leader>Tw'

toggle.diagnostics():map '<Leader>Td'

toggle
  .new({
    id = 'format_on_save_enabled',
    name = 'Format on save',
    get = function()
      return vim.g.format_on_save_enabled
    end,
    set = function(value)
      vim.g.format_on_save_enabled = value
    end,
  })
  :map '<Leader>Tf'
