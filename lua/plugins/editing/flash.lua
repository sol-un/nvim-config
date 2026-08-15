return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  --- @module 'flash'
  --- @type Flash.Config
  --- @diagnostic disable: missing-fields
  opts = { label = { rainbow = { enabled = true } } },
  keys = {
    {
      's',
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
      mode = { 'n', 'x', 'o' },
    },
    {
      'S',
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash',
      mode = { 'n', 'x', 'o' },
    },
    {
      'R',
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Treesitter search',
      mode = { 'x', 'o' },
    },
    {
      'r',
      function()
        require('flash').remote()
      end,
      desc = 'Remote flash',
      mode = 'o',
    },
  },
}
