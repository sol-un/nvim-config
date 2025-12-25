return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function()
      require('nvim-treesitter').install { 'ecma', 'javascript', 'typescript', 'tsx', 'jsdoc' }
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, { 'ts_ls', 'eslint', 'eslint_d' })
    end,
  },
  -- disabling eslint as an LSP, because when used as an LSP and a formatter, the diagnostics will duplicate
  -- this will disable eslint LSP commands like "Fix all fixable eslint errors", but auto-fixing is handled by eslint_d anyway
  { 'mason-org/mason-lspconfig.nvim', opts = { automatic_enable = { exclude = { 'eslint' } } } },
  {
    'mfussenegger/nvim-lint', -- Linters
    event = { 'BufReadPre', 'BufNewFile' },
    opts = { linters_by_ft = { typescript = { 'eslint' }, javascript = { 'eslint' } } },
  },
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      -- prettier may interfere with eslint if it's used for formatting
      local maybe_with_prettier = function()
        if vim.g.prettier_disabled then
          return { 'eslint_d' }
        else
          return { 'eslint_d', 'prettier' }
        end
      end

      opts = vim.tbl_deep_extend('force', opts, {
        formatters_by_ft = {
          typescript = maybe_with_prettier,
          javascript = maybe_with_prettier,
        },
      })

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
    end,
  },
}
