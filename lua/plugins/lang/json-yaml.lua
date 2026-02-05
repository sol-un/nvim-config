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
        'json-lsp',
        'jsonlint',
        'fixjson',
        'yaml-language-server',
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
        json5 = { 'jsonlint' },
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
        json5 = { 'fixjson' },
        yaml = { 'prettier' },
        yml = { 'prettier' },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        'yamlls',
        'jsonls',
      },
    },
  },
  {
    'vuki656/package-info.nvim',
    event = 'BufEnter package.json',
    opts = {},
  },
  {
    'b0o/SchemaStore.nvim',
    lazy = true,
    version = false,
  },
}
