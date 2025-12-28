-- Basic settings for the test runner
-- These are extended for specific languages in {language}.lua files in this directory

return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim',
  },
  opts = {
    adapters = {},
    status = { virtual_text = true },
    output = { open_on_run = true },
    quickfix = {
      open = function()
        require('trouble').open { mode = 'quickfix', focus = false }
      end,
    },
  },
  config = function(_, opts)
    require('neotest').setup(opts)
  end,
  keys = function()
    local neotest = require 'neotest'
    local wk = require 'which-key'

    local prefix = '<Leader>t'
    local watch_prefix = prefix .. 'w'

    wk.add {
      { prefix, group = 'Test' },
      {
        prefix .. 't',
        function()
          neotest.run.run()
        end,
        desc = 'Run test',
      },
      {
        prefix .. 'd',
        function()
          neotest.run.run { strategy = 'dap' }
        end,
        desc = 'Debug test',
      },
      {
        prefix .. 'f',
        function()
          neotest.run.run(vim.fn.expand '%')
        end,
        desc = 'Run all tests in file',
      },
      {
        prefix .. 'p',
        function()
          neotest.run.run(vim.fn.getcwd())
        end,
        desc = 'Run all tests in project',
      },
      {
        prefix .. 's',
        function()
          neotest.summary.toggle()
        end,
        desc = 'Test Summary',
      },
      {
        prefix .. 'O',
        function()
          neotest.output.open { enter = true, auto_close = true }
        end,
        desc = 'Output hover',
      },
      {
        prefix .. 'o',
        function()
          neotest.output_panel.toggle()
        end,
        desc = 'Output window',
      },
      {
        ']T',
        function()
          neotest.jump.next()
        end,
        desc = 'Next test',
      },
      {
        '[T',
        function()
          neotest.jump.prev()
        end,
        desc = 'Previous test',
      },
      {
        watch_prefix .. 't',
        function()
          neotest.watch.toggle()
        end,
        desc = 'Toggle watch test',
      },
      { watch_prefix, group = 'Watch' },
      {
        watch_prefix .. 'f',
        function()
          neotest.watch.toggle(vim.fn.expand '%')
        end,
        desc = 'Toggle watch all test in file',
      },
      {
        watch_prefix .. 'p',
        function()
          neotest.watch.toggle(vim.fn.getcwd())
        end,
        desc = 'Toggle watch all tests in project',
      },
      {
        watch_prefix .. 'S',
        function()
          --- NOTE: The proper type of the argument is missing in the documentation
          ---@see https://github.com/nvim-neotest/neotest/blob/master/doc/neotest.txt#L626-L632
          ---@diagnostic disable-next-line: missing-parameter
          neotest.watch.stop()
        end,
        desc = 'Stop all watches',
      },
    }
  end,
}
