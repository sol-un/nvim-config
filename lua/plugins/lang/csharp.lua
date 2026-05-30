local csharpier = require('null-ls').builtins.formatting.csharpier.with {
  args = { 'format', '--stdin-path', '$FILENAME' },
}

return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'csharpier',
        'lemminx',
      },
    },
  },
  {
    'nvimtools/none-ls.nvim',
    opts = {
      sources = { csharpier },
    },
  },
  -- NOTE: easy-dotnet.nvim sets up LSP and DAP for C# internally, so these require no explicit setup
  {
    'GustavEikaas/easy-dotnet.nvim',
    ft = { 'csproj', 'cs' },
    ---@module "easy-dotnet"
    ---@type easy-dotnet.Options
    opts = {
      -- NOTE: easy-dotnet's built-in test runner is less sophisticated than neotest but can handle large test suites (thousands of tests)
      test_runner = {
        auto_start_testrunner = false,
        hide_legend = true,
        viewmode = 'vsplit',
        vsplit_width = math.floor(vim.o.columns * 0.35),
        -- Set up as consistently as possible with neotest
        mappings = {
          get_build_errors = { lhs = 'e', desc = 'Build errors' },
          debug_test = { lhs = 'd', desc = 'debug' },
          go_to_file = { lhs = 'i', desc = 'jumpto' },
          run_all = { lhs = 'R', desc = 'run all' },
          run = { lhs = 'r', desc = 'run' },
          peek_stacktrace = { lhs = 'o', desc = 'output' },
          expand = { lhs = 'l', desc = 'expand' },
          expand_node = { lhs = 'E', desc = 'expand_all' },
          refresh_testrunner = { lhs = '<C-r>', desc = 'refresh' },
          cancel = { lhs = '<C-c>', desc = 'stop' },
          run_test_from_buffer = { lhs = '<Leader>.tt', desc = 'Run test' },
          run_all_tests_from_buffer = { lhs = '<Leader>.tf', desc = 'Run all tests in file' },
          peek_stack_trace_from_buffer = { lhs = '<Leader>.tO', desc = 'Output hover' },
          debug_test_from_buffer = { lhs = '<Leader>.td', desc = 'Debug test' },
        },
      },
    },
    init = function()
      require('which-key').add {
        {
          '<Leader>.',
          group = '.NET',
          icon = { icon = '󰪮', color = 'blue' },
          {
            '<Leader>.t',
            group = 'Tests',
            {
              '<Leader>.ts',
              '<cmd>Dotnet testrunner<cr>',
              desc = 'Test Summary',
            },
          },
        },
      }
    end,
  },
  {
    'mfussenegger/nvim-dap',
    opts = function()
      -- Preview values of complex types like System.Guid
      require('easy-dotnet.netcoredbg').register_dap_variables_viewer()
    end,
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      {
        'GustavEikaas/easy-dotnet.nvim',
        opts = {
          test_runner = {
            neotest_integration = true,
          },
        },
      },
    },
    opts = function(_, opts)
      -- NOTE: Better UX than easy-dotnet's test runner, but can only handle moderately sized test suites (hundreds of tests)
      table.insert(opts.adapters or {}, require 'easy-dotnet.neotest')
    end,
  },
}
