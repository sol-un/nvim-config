return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'json-lsp',
        'yaml-language-server',
        'yamllint',
        'tombi',
      },
    },
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        yaml = { 'yamllint' },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        toml = { 'tombi' },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        'yamlls',
        'jsonls',
        'tombi',
      },
    },
  },
  {
    'b0o/SchemaStore.nvim',
    lazy = true,
    version = false,
  },
}
