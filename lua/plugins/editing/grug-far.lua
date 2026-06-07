return {
  'MagicDuck/grug-far.nvim',
  --- @module 'grug-far'
  --- @type grug.far.OptionsOverride
  --- @diagnostic disable: missing-fields
  opts = {
    folding = {
      enabled = false,
    },
    engines = {
      ripgrep = {
        placeholders = {
          paths = 'e.g. /foo/bar or a built-in provider (<buflist>, <buflist-cwd>, <qflist>, <loclist>)',
        },
      },
    },
  },
  init = function()
    require('which-key').add {
      {
        '<Leader>rb',
        function()
          require('grug-far').open {
            prefills = { paths = vim.fn.expand '%:p' },
          }
        end,
        desc = 'Current buffer',
      },
      {
        '<Leader>ro',
        function()
          require('grug-far').open {
            prefills = { paths = '<buflist>' },
          }
        end,
        desc = 'Open buffers',
      },
      {
        '<Leader>rc',
        function()
          require('grug-far').open {
            prefills = { paths = vim.fn.getcwd() },
          }
        end,
        desc = 'CWD',
      },
      {
        '<Leader>r',
        function()
          local grug_far = require 'grug-far'
          local range = grug_far.get_current_visual_selection_as_range_str()

          grug_far.open {
            visualSelectionUsage = 'ignore',
            prefills = { paths = range },
          }
        end,
        desc = 'Search & replace (selection)',
        mode = 'v',
      },
    }
  end,
  keys = '<Leader>r',
}
