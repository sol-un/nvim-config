-- Basic settings for the plugins adding language support to neovim
-- These are extended for specific languages in {language}.lua files in this directory

local prettier_supported_fts = {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
  'vue',
  'css',
  'scss',
  'less',
  'html',
  'json',
  'json5',
  'jsonc',
  'yaml',
  'markdown',
  'markdown.mdx',
  'graphql',
  'handlebars',
  'svelte',
  'astro',
  'htmlangular',
}

return {
  {
    'nvim-treesitter/nvim-treesitter', -- language AST parsers
    lazy = false,
    build = ':TSUpdate',
    opts = function()
      require('nvim-treesitter').install { 'all' }
    end,
  },
  {
    'mason-org/mason.nvim', -- package manager for LSP servers, DAP servers, linters, and formatters
    --- @module 'mason'
    --- @type MasonSettings
    --- @diagnostic disable: missing-fields
    opts = {},
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim', -- automatically installs mason packages
    opts_extend = { 'ensure_installed' },
    --- @module 'mason-tool-installer'
    --- @type MasonToolInstallerSettings
    --- @diagnostic disable: missing-fields
    opts = {
      auto_update = true,
      ensure_installed = { 'prettierd', 'codebook' },
    },
  },
  {
    'neovim/nvim-lspconfig', -- provides community-maintained LSP server configs, which can be extended (see  ../../../after/lsp/)
    opts_extend = { 'servers' },
    opts = {
      servers = { 'codebook' },
    },
    config = function(_, opts)
      for _, server in ipairs(opts.servers or {}) do
        vim.lsp.enable(server)
      end
    end,
  },
  {
    'mfussenegger/nvim-lint', -- Linters
    opts = {},
    config = function(_, opts)
      require('lint').linters_by_ft = opts.linters_by_ft
    end,
  },
  {
    'stevearc/conform.nvim', -- Formatters
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {},
      default_format_opts = {
        timeout_ms = 3000,
        lsp_format = 'fallback',
      },
    },
    config = function(_, opts)
      -- Run prettierd last on the filetypes it supports, after any language-specific formatter contributed by a {language}.lua file
      for _, filetype in ipairs(prettier_supported_fts) do
        local formatters = vim.list_extend({}, opts.formatters_by_ft[filetype] or {})
        table.insert(formatters, 'prettierd')
        opts.formatters_by_ft[filetype] = formatters
      end

      require('conform').setup(opts)
    end,
  },
}
