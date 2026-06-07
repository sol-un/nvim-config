local helpers = require 'null-ls.helpers'
local methods = require 'null-ls.methods'
local yamllint = require 'none-ls.diagnostics.yamllint'

local FORMATTING = methods.internal.FORMATTING

local tombi = helpers.make_builtin {
  name = 'tombi',
  method = FORMATTING,
  filetypes = { 'toml' },
  generator_opts = {
    command = 'tombi',
    args = {
      'format',
      '-',
    },
    to_stdin = true,
  },
  factory = helpers.formatter_factory,
}

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
    'nvimtools/none-ls.nvim',
    opts = {
      sources = { yamllint, tombi },
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
