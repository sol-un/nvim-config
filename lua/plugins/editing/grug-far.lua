return {
  'MagicDuck/grug-far.nvim',
  cmd = { 'GrugFarWithin' },
  ---@module 'grug-far'
  ---@type grug.far.OptionsOverride
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
        '<Leader>r',
        "<cmd>'<,'>GrugFarWithin<cr>",
        desc = 'Search & replace (selection)',
        mode = 'v',
      },
    }
  end,
  keys = '<Leader>r',
}
