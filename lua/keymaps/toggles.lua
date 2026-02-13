local toggle = require('snacks').toggle

require('which-key').add { { '<Leader>T', group = 'Toggles' } }
toggle.option('wrap', { name = 'Wrap' }):map '<Leader>Tw'
toggle.option('scrolloff', { name = 'Scrolloff', on = 99, off = 4 }):map '<Leader>Ts'

toggle.diagnostics():map '<Leader>Td'
