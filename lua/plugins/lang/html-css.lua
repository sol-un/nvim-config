return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'html-lsp',
        'htmlhint',
        'css-lsp',
        'css-variables-language-server',
        'cssmodules-language-server',
        'stylelint',
        'some-sass-language-server',
        'emmet-language-server',
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
        'emmet_language_server',
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
        less = { 'stylelint' },
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
        less = { 'prettier' },
      },
    },
  },
}
