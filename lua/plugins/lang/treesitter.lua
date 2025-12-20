return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  lazy = false,
  build = ':TSUpdate',
  opts = { ensure_installed = { 'bash', 'markdown', 'markdown_inline', 'regex', 'vim' } },
}
