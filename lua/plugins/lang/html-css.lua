return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'html-lsp',
        'css-lsp',
        'css-variables-language-server',
        'cssmodules-language-server',
        'some-sass-language-server',
        'markuplint',
        'stylelint',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        'html',
        'cssls',
        'css_variables',
        'cssmodules_ls',
        'somesass_ls',
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        css = { 'stylelint' },
        scss = { 'stylelint' },
        less = { 'stylelint' },
      },
    },
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        html = { 'markuplint' },
        css = { 'stylelint' },
        scss = { 'stylelint' },
        less = { 'stylelint' },
      },
    },
  },
}
