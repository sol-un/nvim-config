return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  --- @module 'flash'
  --- @type Flash.Config
  --- @diagnostic disable: missing-fields
  opts = { label = { rainbow = { enabled = true } } },
  keys = function()
    local wk = require 'which-key'
    local flash = require 'flash'

    wk.add {
      { 's', flash.jump, desc = 'Flash', mode = { 'n', 'x', 'o' } },
      { 'S', flash.treesitter, desc = 'Flash', mode = { 'n', 'x', 'o' } },
      { 'R', flash.treesitter_search, desc = 'Treesitter search', mode = { 'x', 'o' } },
      { 'r', flash.remote, desc = 'Remote flash', mode = 'o' },
    }
  end,
}
