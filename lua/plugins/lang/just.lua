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
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        just = { 'just' },
      },
    },
  },
}
