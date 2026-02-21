return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'csharpier',
        'lemminx',
        'netcoredbg',
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        cs = { 'csharpier' },
      },
    },
  },
  -- provides an LSP and other C#-related features
  -- NOTE: EasyDotnet tool must be installed for this to work (dotnet tool install -g EasyDotnet)
  {
    'GustavEikaas/easy-dotnet.nvim',
    ft = { 'csproj', 'cs' },
    opts = {},
  },
  {
    'mfussenegger/nvim-dap',
    opts = function()
      local dap = require 'dap'

      -- Expands complex types like System.Guid
      require('easy-dotnet.netcoredbg').register_dap_variables_viewer()

      dap.adapters.netcoredbg = {
        type = 'executable',
        command = 'netcoredbg',
        args = { '--interpreter=vscode' },
      }

      dap.configurations.cs = {
        {
          type = 'netcoredbg',
          name = 'Launch - netcoredbg',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
          end,
        },
        {
          type = 'netcoredbg',
          name = 'Attach - netcoredbg',
          request = 'attach',
          processId = function()
            return require('dap.utils').pick_process()
          end,
        },
      }
    end,
  },
  {
    'nvim-neotest/neotest',
    opts = function(_, opts)
      table.insert(opts.adapters or {}, require 'neotest-vstest'())
    end,
  },
}
