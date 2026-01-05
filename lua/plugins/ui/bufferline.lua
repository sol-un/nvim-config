return {
  'akinsho/bufferline.nvim',
  opts = {
    options = {
      show_buffer_close_icons = false,
      show_close_icon = false,
      diagnostics = 'nvim_lsp',
      sort_by = 'relative_directory',
      separator_style = { '', '' },
      indicator = {
        style = 'none',
      },
      tab_size = 0,
    },
    highlights = {
      pick = {
        fg = {
          highlight = 'Special',
          attribute = 'fg',
        },
      },
      pick_selected = {
        fg = {
          highlight = 'Special',
          attribute = 'fg',
        },
      },
      modified_selected = {
        fg = {
          highlight = 'Normal',
          attribute = 'fg',
        },
      },
    },
  },
}
