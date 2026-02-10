-- Basic settings for the plugins adding language support to neovim
-- These are extended for specific languages in {language}.lua files in this directory

return {
  {
    'nvim-treesitter/nvim-treesitter', -- language AST parsers
    lazy = false,
    build = ':TSUpdate',
    opts = function()
      require('nvim-treesitter').install { 'all' }
    end,
  },
  { 'mason-org/mason.nvim', opts = {} }, -- package manager for LSP servers, DAP servers, linters, and formatters
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim', -- automatically installs mason packages
    opts_extend = { 'ensure_installed' },
    opts = {
      auto_update = true,
      ensure_installed = { 'prettier' },
    },
  },
  {
    'neovim/nvim-lspconfig', -- provides LSP server configs
    opts_extend = { 'servers' },
    config = function(_, opts)
      for _, server in ipairs(opts.servers or {}) do
        vim.lsp.enable(server)
      end
    end,
  },
  {
    'mfussenegger/nvim-lint', -- Linters
    config = function(_, opts)
      require('lint').linters_by_ft = opts.linters_by_ft
    end,
  },
  {
    'stevearc/conform.nvim', -- Formatters
    keys = {
      {
        'glf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        desc = 'Format buffer',
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
