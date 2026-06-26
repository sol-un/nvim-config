return {
  '3rd/image.nvim',
  cond = require('utils').is_kitty(),
  build = false,
  opts = {
    processor = 'magick_cli',
  },
}
