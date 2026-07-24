local stylelint_diagnostics = require('null-ls').builtins.diagnostics.stylelint
local stylelint_formatting = require('null-ls').builtins.formatting.stylelint
local markuplint = require('null-ls').builtins.diagnostics.markuplint

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
    'nvimtools/none-ls.nvim',
    opts = {
      sources = {
        stylelint_diagnostics,
        stylelint_formatting,
        markuplint,
      },
    },
  },
}
