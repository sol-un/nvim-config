-- Basic settings for the plugins adding language support to neovim
-- These are extended for specific languages in {language}.lua files in this directory

local prettier_supported_fts = {
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
  vue = true,
  css = true,
  scss = true,
  less = true,
  html = true,
  json = true,
  json5 = true,
  jsonc = true,
  yaml = true,
  markdown = true,
  graphql = true,
  handlebars = true,
  svelte = true,
  astro = true,
  htmlangular = true,
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
      formatters_by_ft = {
        ['*'] = function(bufnr)
          local ft = vim.bo[bufnr].filetype
          if prettier_supported_fts[ft] then
            return { 'prettierd' }
          end

          return {}
        end,
      },
      default_format_opts = {
        timeout_ms = 3000,
        lsp_format = 'fallback',
      },
    },
  },
}
