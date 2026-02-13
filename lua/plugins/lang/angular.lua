return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'angular-language-server',
        version = '11.2.14',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = { 'angularls' },
    },
  },
}
