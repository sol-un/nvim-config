local markdownlint = require('null-ls').builtins.diagnostics.markdownlint.with {
  extra_args = { '--disable', 'MD013', 'MD033' },
}

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
    'nvimtools/none-ls.nvim',
    opts = {
      sources = { markdownlint },
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
