-- Basic settings for the plugins adding language support to neovim
-- These are extended for specific languages in {language}.lua files in this directory

-- Prettier can be disabled globally
vim.g.prettier_enabled = true
local prettier_conditional = {
  runtime_condition = function()
    return vim.g.prettier_enabled
  end,
}

local snacks = require 'snacks'
local toggle = snacks.toggle
toggle
  .new({
    id = 'prettier_enabled',
    name = 'Prettier',
    get = function()
      return vim.g.prettier_enabled
    end,
    set = function(value)
      vim.g.prettier_enabled = value
    end,
  })
  :map '<Leader>Tf'

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
      ensure_installed = { 'prettierd', 'codebook', 'just-lsp' },
    },
  },
  {
    'neovim/nvim-lspconfig', -- provides community-maintained LSP server configs, which can be extended (see  ../../../after/lsp/)
    opts_extend = { 'servers' },
    opts = {
      servers = { 'codebook', 'just' },
    },
    config = function(_, opts)
      for _, server in ipairs(opts.servers or {}) do
        vim.lsp.enable(server)
      end
    end,
  },
  {
    'nvimtools/none-ls.nvim', -- injects LSP diagnostics from preconfigured sources (linters, formatters etc)
    dependencies = { 'nvimtools/none-ls-extras.nvim' },
    opts_extend = { 'sources' },
    config = function(_, opts)
      local null_ls = require 'null-ls'

      vim.list_extend(opts.sources or {}, {
        null_ls.builtins.formatting.prettierd.with(prettier_conditional),
      })

      null_ls.setup(opts)
    end,
  },
}
