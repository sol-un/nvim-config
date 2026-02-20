return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      vim.list_extend((opts.ensure_installed or {}), { { 'angular-language-server', version = '11.2.14' } })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = { 'angularls' },
    },
  },
}
