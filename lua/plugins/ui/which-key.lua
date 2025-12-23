return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 0,
    show_help = false,
    preset = 'helix',
    icons = {
      mappings = vim.g.have_nerd_font,
    },
  },
}
