local filetypes = {
  'javascript',
  'javascriptreact',
  'javascript.jsx',
  'typescript',
  'typescriptreact',
  'typescript.tsx',
}

local adapters = {
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    cwd = '${workspaceFolder}',
    resolveSourceMapLocations = {
      '${workspaceFolder}/**',
      '!**/node_modules/**',
    },
  },
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch file (tsx)',
    program = '${file}',
    cwd = '${workspaceFolder}',
    runtimeArgs = { '--import', 'tsx/esm' },
    resolveSourceMapLocations = {
      '${workspaceFolder}/**',
      '!**/node_modules/**',
    },
  },
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch file with args',
    program = '${file}',
    cwd = '${workspaceFolder}',
    resolveSourceMapLocations = {
      '${workspaceFolder}/**',
      '!**/node_modules/**',
    },
    args = function()
      local args_string = vim.fn.input 'Arguments: '
      if args_string and args_string ~= '' then
        return vim.split(args_string, ' ')
      end
      return nil
    end,
  },
  {
    type = 'pwa-chrome',
    name = 'Launch Chrome',
    request = 'launch',
    sourceMaps = true,
    protocol = 'inspector',
    port = 9222,
    webRoot = '${workspaceFolder}/src',
    skipFiles = { '**/node_modules/**/*', '**/src/*' },
  },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function()
    ---@diagnostic disable: assign-type-mismatch
    require('which-key').add {
      {
        'glu',
        function()
          vim.lsp.buf.code_action {
            apply = true,
            context = {
              only = { 'source.removeUnused.ts' },
              diagnostics = {},
            },
          }
        end,
        desc = 'Remove unused code',
      },
      {
        'glA',
        function()
          vim.lsp.buf.code_action {
            apply = true,
            context = {
              only = { 'source.addMissingImports.ts' },
              diagnostics = {},
            },
          }
        end,
        desc = 'Add missing imports',
      },
    }
    ---@diagnostic enable: assign-type-mismatch
  end,
})

return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'typescript-language-server',
        'eslint-lsp',
        'eslint_d',
        'js-debug-adapter',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        'ts_ls',
      },
    },
  },
  {
    'mfussenegger/nvim-lint', -- Linters
    opts = function(_, opts)
      for _, filetype in pairs(filetypes) do
        opts.linters_by_ft[filetype] = { 'eslint' }
      end
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      for _, filetype in pairs(filetypes) do
        opts.formatters_by_ft[filetype] = { 'eslint_d' }
      end

      return opts
    end,
  },
  {
    'mfussenegger/nvim-dap',
    opts = function()
      local dap = require 'dap'

      for _, adapter in pairs { 'pwa-node', 'pwa-chrome' } do
        dap.adapters[adapter] = {
          type = 'server',
          port = '${port}',
          executable = {
            command = 'js-debug-adapter',
            args = { '${port}' },
          },
        }
      end

      for _, filetype in pairs(filetypes) do
        dap.configurations[filetype] = adapters
      end
    end,
  },
  {
    'nvim-neotest/neotest',
    dependencies = { 'nvim-neotest/neotest-jest' },
    opts = function(_, opts)
      table.insert(
        opts.adapters or {},
        require 'neotest-jest' {
          -- this will allow nvim-dap to attach to a Jest process
          -- see https://jestjs.io/docs/ecmascript-modules and https://jestjs.io/docs/troubleshooting#tests-are-failing-and-you-dont-know-why
          jestCommand = 'node --inspect --experimental-vm-modules node_modules/.bin/jest --runInBand',
        }
      )
    end,
  },
  {
    'dmmulroy/tsc.nvim',
    opts = {
      use_trouble_qflist = true,
    },
  },
}
