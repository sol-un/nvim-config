return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = { 'angular-language-server' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = { 'angularls' },
    },
  },
}
