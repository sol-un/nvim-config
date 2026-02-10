--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

require 'lazy-setup'

require 'keymaps.common'
require 'keymaps.lsp'
require 'keymaps.toggles'
require 'keymaps.pickers'
require 'keymaps.buffers'

require 'options'

require 'autocmds'
