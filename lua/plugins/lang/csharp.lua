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
  -- NOTE: easy-dotnet.nvim sets up LSP and DAP for C# internally and ships with its own test runner, so neotest, nvim-lspconfig etc aren't needed
  {
    'GustavEikaas/easy-dotnet.nvim',
    ft = { 'csproj', 'cs' },
    ---@module "easy-dotnet"
    ---@type easy-dotnet.Options
    opts = {
      test_runner = {
        auto_start_testrunner = false,
        hide_legend = true,
        viewmode = 'vsplit',
        vsplit_width = math.floor(vim.o.columns * 0.35),
      },
    },
    init = function()
      require('which-key').add {
        { '<Leader>.', group = '.NET', icon = { icon = '󰪮', color = 'blue' } },
        { '<Leader>.t', '<cmd>Dotnet testrunner<cr>', desc = 'Toggle test runner' },
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
}
