return {
  'sphamba/smear-cursor.nvim',
  enabled = not vim.g.neovide,
  opts = { min_horizontal_distance_smear = 2, min_vertical_distance_smear = 2 },
}
