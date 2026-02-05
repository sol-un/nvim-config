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
    'nvim-treesitter/nvim-treesitter',
    opts = function()
      require('nvim-treesitter').install { 'ecma', 'javascript', 'typescript', 'jsx', 'tsx', 'jsdoc' }
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, { 'typescript-language-server', 'eslint-lsp', 'eslint_d', 'js-debug-adapter' })
    end,
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
      -- prettier may interfere with eslint if the latter is used as a formatter
      -- providing an option to disable prettier in this case
      local maybe_with_prettier = function()
        if vim.g.prettier_disabled then
          return { 'eslint_d' }
        else
          return { 'eslint_d', 'prettier' }
        end
      end

      for _, filetype in pairs(filetypes) do
        opts.formatters_by_ft[filetype] = maybe_with_prettier
      end

      return opts
    end,
    keys = function()
      require('snacks').keymap.set('n', '<Leader>Tf', function()
        vim.g.prettier_disabled = not vim.g.prettier_disabled
      end, { desc = 'Toggle prettier', ft = filetypes })
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
}
