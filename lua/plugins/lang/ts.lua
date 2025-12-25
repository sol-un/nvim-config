-- eslint and eslint_d will create duplicate diagnostics
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Hide diagnostics from eslint',
  callback = function()
    local ns = require('lint').get_namespace 'eslint'
    vim.diagnostic.config({ virtual_lines = false, virtual_text = false, underline = false }, ns)
  end,
})

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
