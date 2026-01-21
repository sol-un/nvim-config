local toggle = require('snacks').toggle

require('which-key').add { { '<Leader>T', group = 'Toggles' } }
toggle.option('wrap', { name = 'Wrap' }):map '<Leader>Tw'
toggle.option('scrolloff', { name = 'Scrolloff', on = 99, off = 4 }):map '<Leader>Ts'

toggle
  .new({
    id = 'clock_visible',
    name = 'Clock',
    get = function()
      return vim.g.clock_visible
    end,
    set = function(value)
      vim.g.clock_visible = value
    end,
  })
  :map '<Leader>Tc'

toggle.diagnostics():map '<Leader>Td'
