return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function()
      require('nvim-treesitter').install { 'json', 'yaml' }
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        'jsonls',
        'jsonlint',
        'fixjson',
        'yamlls',
        'yamllint',
      })
    end,
  },
  {
    'mfussenegger/nvim-lint', -- Linters
    opts = {
      linters_by_ft = {
        json = { 'jsonlint' },
        jsonc = { 'jsonlint' },
        yaml = { 'yamllint' },
        yml = { 'yamllint' },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        json = { 'fixjson' },
        jsonc = { 'fixjson' },
        yaml = { 'prettier' },
        yml = { 'prettier' },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        yamlls = {
          before_init = function(_, config)
            (config.settings or {}).yaml.schemas = require('schemastore').yaml.schemas()
          end,
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = { schemaStore = { enable = false, url = '' }, validate = true },
          },
        },
        jsonls = {
          before_init = function(_, config)
            (config.settings or {}).json.schemas = require('schemastore').json.schemas()
          end,
          settings = {
            json = { validate = { enable = true } },
          },
        },
      },
    },
  },
  { 'vuki656/package-info.nvim', opts = {} },
  {
    'b0o/SchemaStore.nvim',
    lazy = true,
    version = false,
  },
}
