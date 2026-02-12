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
  { 'GustavEikaas/easy-dotnet.nvim', ft = { 'cs', 'csproj', 'sln' }, opts = {} },
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
  -- TODO: Currently defined in blink-cmp settings. Should merge from here
  -- {
  --   'saghen/blink.cmp',
  --   opts = function(_, opts)
  --     return vim.tbl_deep_extend('force', opts, {
  --       sources = {
  --         default = { 'easy-dotnet' },
  --         providers = {
  --           ['easy-dotnet'] = {
  --             name = 'easy-dotnet',
  --             enabled = true,
  --             module = 'easy-dotnet.completion.blink',
  --             score_offset = 10000,
  --             async = true,
  --           },
  --         },
  --       },
  --     })
  --   end,
  -- },
  'nsidorenco/neotest-vstest',
  {
    'nvim-neotest/neotest',
    opts = function(_, opts)
      table.insert(opts.adapters or {}, require 'neotest-vstest'())
    end,
  },
}
