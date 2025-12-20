local prefix = 'gz'

return {
  'nvim-mini/mini.surround',
  opts = {
    mappings = {
      add = prefix .. 'a', -- Add surrounding in Normal and Visual modes
      delete = prefix .. 'd', -- Delete surrounding
      find = prefix .. 'f', -- Find surrounding (to the right)
      find_left = prefix .. 'F', -- Find surrounding (to the left)
      highlight = prefix .. 'h', -- Highlight surrounding
      replace = prefix .. 'r', -- Replace surrounding
      update_n_lines = prefix .. 'n', -- Update `n_lines`
    },
  },
}
