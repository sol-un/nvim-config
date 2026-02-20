-- Basic settings for the plugins adding language support to neovim
-- These are extended for specific languages in {language}.lua files in this directory

-- For debugging
vim.api.nvim_create_user_command('PrintActiveLangFeatures', function()
  local linters = require('lint')._resolve_linter_by_ft(vim.bo.filetype)

  local formatters = require('conform').list_formatters(0)
  local formatter_names = vim
    .iter(formatters)
    :map(function(formatter)
      return formatter.name
    end)
    :totable()

  local lsp_client_names = vim
    .iter(vim.lsp.get_clients())
    :map(function(client)
      return client.name
    end)
    :totable()

  vim.notify(vim.inspect {
    lsp_clients = lsp_client_names,
    linters = linters,
    formatters = formatter_names,
  })
end, {})

-- Prettier can be disabled globally
vim.g.prettier_enabled = true
local maybe_with_prettier = function()
  if vim.g.prettier_enabled then
    return { 'prettier' }
  else
    return {}
  end
end

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
      ensure_installed = { 'prettier', 'codebook', 'just-lsp' },
    },
  },
  {
    'neovim/nvim-lspconfig', -- provides LSP server configs
    opts = {
      servers = { 'codebook', 'just' },
    },
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
    opts = {
      formatters_by_ft = {
        ['*'] = maybe_with_prettier,
      },
    },
    init = function()
      local snacks = require 'snacks'
      local set, toggle = snacks.keymap.set, snacks.toggle

      set('n', 'glf', function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end, { desc = 'Format buffer' })

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
    end,
  },
}
