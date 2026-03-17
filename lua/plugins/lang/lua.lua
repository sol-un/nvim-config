return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'lua-language-server',
        'stylua',
        'selene',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = { 'lua_ls' },
    },
  },
  {
    'mfussenegger/nvim-lint',
    opts = { linters_by_ft = { lua = { 'selene' } } },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
  },
  {
    'folke/lazydev.nvim', -- used for completion, annotations and signatures of Neovim apis
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
}
