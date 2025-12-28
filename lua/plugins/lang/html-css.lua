return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function()
      require('nvim-treesitter').install { 'html', 'html_tags', 'css', 'scss' }
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        'html-lsp',
        'htmlhint',
        'css-lsp',
        'css-variables-language-server',
        'cssmodules-language-server',
        'stylelint',
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        html = {},
        cssls = {},
        cssmodules_ls = {},
        css_variables = {},
      },
    },
  },
  {
    'mfussenegger/nvim-lint', -- Linters
    opts = {
      linters_by_ft = {
        html = { 'htmlhint' },
        css = { 'stylelint' },
        scss = { 'stylelint' },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        html = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
      },
    },
  },
}
