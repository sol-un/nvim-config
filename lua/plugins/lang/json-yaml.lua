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
        'yamlfix',
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
        yaml = { 'yamlfix' },
        yml = { 'yamlfix' },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        yamlls = {

          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = { schemaStore = { enable = false, url = '' }, validate = true },
          },
        },
        jsonls = {
          settings = {
            json = { validate = { enable = true } },
          },
        },
      },
    },
  },
  'vuki656/package-info.nvim', -- display latest dependency versions in package.json
  {
    -- TODO: loading schemas does not actually work; should investigate this further
    'b0o/SchemaStore.nvim', --
    lazy = true,
    version = false,
  },
}
