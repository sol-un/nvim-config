local yamllint = require 'none-ls.diagnostics.yamllint'

return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'json-lsp',
        'yaml-language-server',
        'yamllint',
      },
    },
  },
  {
    'nvimtools/none-ls.nvim',
    opts = {
      sources = { yamllint },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        'yamlls',
        'jsonls',
      },
    },
  },
  {
    'vuki656/package-info.nvim',
    event = 'BufEnter package.json',
    opts = {},
  },
  {
    'b0o/SchemaStore.nvim',
    lazy = true,
    version = false,
  },
}
