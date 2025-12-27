-- Basic settings for the plugins adding language support to neovim
-- These are extended for specific languages in {language}.lua files in this directory

return {
  {
    'nvim-treesitter/nvim-treesitter', -- language AST parsers
    lazy = false,
    build = ':TSUpdate',
    opts = function()
      require('nvim-treesitter').install {
        'bash',
        'regex',
        'vim',
        'comment',
        'diff',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'git_config',
        'git_rebase',
        'make',
        'vim',
        'vimdoc',
      }
    end,
  },
  { 'mason-org/mason.nvim', opts = {} }, -- package manager for LSP servers, DAP servers, linters, and formatters
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim', -- automatically installs mason packages
    opts = { auto_update = true, ensure_installed = { 'prettier' } },
  },
  'neovim/nvim-lspconfig', -- provides LSP server configs
  { 'mason-org/mason-lspconfig.nvim', opts = {} }, -- translates between nvim-lspconfig server names and mason package names; automatically enables installed LSPs
  {
    'mfussenegger/nvim-lint', -- Linters
    event = { 'BufReadPre', 'BufNewFile' },
    config = function(_, opts)
      require('lint').linters_by_ft = opts.linters_by_ft
    end,
  },
  {
    'stevearc/conform.nvim', -- Formatters
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    config = function(_, opts)
      require('conform').setup(opts)
    end,
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
