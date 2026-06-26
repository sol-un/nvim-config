return {
  'sphamba/smear-cursor.nvim',
  -- NOTE: kitty features a built-in cursor smear effect; add "cursor_trail 1" to kitty.conf to enable
  cond = require('utils').is_kitty(),
  opts = { min_horizontal_distance_smear = 2, min_vertical_distance_smear = 2 },
}
