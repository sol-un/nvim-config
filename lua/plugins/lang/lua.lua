return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function()
      require('nvim-treesitter').install { 'lua', 'luadoc', 'luap' }
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, { 'lua-language-server', 'stylua', 'selene' })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = { 'lua_ls' },
    },
  },
  {
    'mfussenegger/nvim-lint', -- Linters
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
