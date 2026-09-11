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
    --- @diagnostic disable: assign-type-mismatch
    require('which-key').add {
      {
        'glu',
        function()
          vim.lsp.buf.code_action {
            apply = true,
            context = {
              only = { 'source.removeUnusedImports' },
              diagnostics = {},
            },
          }
        end,
        desc = 'Remove unused imports',
      },
      {
        'glA',
        function()
          vim.lsp.buf.code_action {
            apply = true,
            context = {
              only = { 'source.fixAll' },
              diagnostics = {},
            },
          }
        end,
        desc = 'Fix all',
      },
    }
    --- @diagnostic enable: assign-type-mismatch
  end,
})

return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'tsc',
        'eslint_d',
        'eslint-lsp',
        'js-debug-adapter',
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      for _, filetype in ipairs(filetypes) do
        opts.formatters_by_ft[filetype] = { 'eslint_d' }
      end

      return opts
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        'tsc',
        'eslint',
      },
    },
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
    cmd = 'TSC',
    opts = {
      use_trouble_qflist = true,
    },
  },
  {
    'vuki656/package-info.nvim',
    event = 'BufEnter package.json',
    opts = {},
    config = function()
      local prefix = '<Leader>pj'
      require('which-key').add {
        {
          prefix,
          group = 'JSON',
          icon = { icon = '󰛷', color = 'red' },
          { prefix .. 'i', '<cmd>PackageInfoInstall<cr>', desc = 'Install' },
          { prefix .. 'u', '<cmd>PackageInfoUpdate<cr>', desc = 'Update' },
          { prefix .. 'd', '<cmd>PackageInfoDelete<cr>', desc = 'Uninstall' },
          { prefix .. 'v', '<cmd>PackageInfoChangeVersion<cr>', desc = 'Change version' },
        },
      }
    end,
  },
}
