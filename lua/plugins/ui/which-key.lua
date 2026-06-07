return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  --- @module 'which-key'
  --- @type wk.Opts
  --- @diagnostic disable: missing-fields
  opts = {
    delay = 0,
    show_help = false,
    preset = 'helix',
    icons = {
      mappings = vim.g.have_nerd_font,
    },
  },
}
