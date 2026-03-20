local just = require('null-ls').builtins.formatting.just

return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = { 'just-lsp' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = { 'just' },
    },
  },
  {
    'nvimtools/none-ls.nvim',
    opts = {
      sources = { just },
    },
  },
}
