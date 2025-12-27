local filetypes = {
  'javascript',
  'javascriptreact',
  'javascript.jsx',
  'typescript',
  'typescriptreact',
  'typescript.tsx',
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
      vim.list_extend(opts.ensure_installed or {}, { 'ts_ls', 'eslint', 'eslint_d' })
    end,
  },
  -- disabling eslint as an LSP, because when used as an LSP *and* a linter, the diagnostics will duplicate
  -- this will disable eslint LSP commands like "Fix all fixable eslint errors", but auto-fixing is handled by eslint_d anyway
  { 'mason-org/mason-lspconfig.nvim', opts = { automatic_enable = { exclude = { 'eslint' } } } },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ts_ls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
              implementationsCodeLens = { enabled = true },
              referencesCodeLens = { enabled = true, showOnAllFunctions = true },
            },
          },
        },
      },
    },
  },
  {
    'mfussenegger/nvim-lint', -- Linters
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function(_, opts)
      for _, filetype in pairs(filetypes) do
        opts.linters_by_ft[filetype] = { 'eslint' }
      end

      return opts
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
    keys = { {
      '<Leader>tf',
      function()
        vim.g.prettier_disabled = not vim.g.prettier_disabled
      end,
    } },
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
        dap.configurations[filetype] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            cwd = '${workspaceFolder}',
            protocol = 'inspector',
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
      end
    end,
  },
}
