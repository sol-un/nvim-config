-- Basic settings for the test runner
-- These are extended for specific languages in {language}.lua files in this directory

local prefix = '<Leader>t'

return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim',
  },
  ---@module 'neotest'
  ---@type neotest.Config
  opts = {
    adapters = {},
    status = { virtual_text = true },
    output = { open_on_run = true },
    summary = {
      mappings = {
        expand = 'l',
        expand_all = 'E',
        stop = '<C-c>',
      },
    },
    quickfix = {
      open = function()
        require('trouble').open { mode = 'quickfix', focus = false }
      end,
    },
  },
  keys = { { prefix, desc = 'Test' } },
  init = function()
    local watch_prefix = prefix .. 'w'

    require('which-key').add {
      { prefix, group = 'Test' },
      {
        prefix .. 't',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run test',
      },
      {
        prefix .. 'd',
        function()
          require('neotest').run.run { strategy = 'dap' }
        end,
        desc = 'Debug test',
      },
      {
        prefix .. 'f',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = 'Run all tests in file',
      },
      {
        prefix .. 'p',
        function()
          require('neotest').run.run(vim.fn.getcwd())
        end,
        desc = 'Run all tests in project',
      },
      {
        prefix .. 's',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Test Summary',
      },
      {
        prefix .. 'O',
        function()
          require('neotest').output.open { enter = true, auto_close = true }
        end,
        desc = 'Output hover',
      },
      {
        prefix .. 'o',
        function()
          require('neotest').output_panel.toggle()
        end,
        desc = 'Output window',
      },
      {
        ']T',
        function()
          require('neotest').jump.next()
        end,
        desc = 'Next test',
      },
      {
        '[T',
        function()
          require('neotest').jump.prev()
        end,
        desc = 'Previous test',
      },
      {
        watch_prefix .. 't',
        function()
          require('neotest').watch.toggle()
        end,
        desc = 'Toggle watch test',
      },
      { watch_prefix, group = 'Watch' },
      {
        watch_prefix .. 'f',
        function()
          require('neotest').watch.toggle(vim.fn.expand '%')
        end,
        desc = 'Toggle watch all test in file',
      },
      {
        watch_prefix .. 'p',
        function()
          require('neotest').watch.toggle(vim.fn.getcwd())
        end,
        desc = 'Toggle watch all tests in project',
      },
      {
        watch_prefix .. 'S',
        function()
          --- NOTE: The proper type of the argument is missing in the documentation
          ---@see https://github.com/nvim-neotest/neotest/blob/master/doc/neotest.txt#L626-L632
          ---@diagnostic disable-next-line: missing-parameter
          require('neotest').watch.stop()
        end,
        desc = 'Stop all watches',
      },
    }
  end,
}
