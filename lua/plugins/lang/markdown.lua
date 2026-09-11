local markdownlint = require('lint').linters.markdownlint
vim.list_extend(markdownlint.args, {
  '--disable',
  'MD013',
  'MD033',
})

return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'marksman',
        'markdownlint',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = { 'marksman' },
    },
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        markdown = { 'markdownlint' },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        markdown = { 'markdownlint' },
      },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'gitlab' },
    --- @module 'render-markdown'
    --- @type render.md.UserConfig
    opts = {
      preset = 'obsidian',
      file_types = { 'markdown', 'gitlab' },
    },
  },
}
