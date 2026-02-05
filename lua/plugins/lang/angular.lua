return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function()
      require('nvim-treesitter').install { 'angular' }
    end,
  },
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
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        htmlangular = { 'prettier' },
      },
    },
  },
}
