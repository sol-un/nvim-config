return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {},
  keys = function()
    local set = vim.keymap.set
    local flash = require 'flash'

    set({ 'n', 'x', 'o' }, 's', flash.jump, { desc = 'Flash' })
    set({ 'n', 'x', 'o' }, 'S', flash.treesitter, { desc = 'Flash' })
    set({ 'x', 'o' }, 'R', flash.treesitter_search, { desc = 'Treesitter search' })
    set('o', 'r', flash.remote, { desc = 'Remote flash' })
  end,
}
