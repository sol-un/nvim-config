return {
  'akinsho/bufferline.nvim',
  opts = {
    options = {
      always_show_bufferline = true,
      close_command = function(n)
        require('snacks').bufdelete(n)
      end,
      show_buffer_close_icons = false,
      show_close_icon = false,
      diagnostics = 'nvim_lsp',
      sort_by = 'relative_directory',
      separator_style = { '', '' },
      indicator = {
        style = 'none',
      },
      tab_size = 0,
      custom_filter = function(buf_number)
        return vim.bo[buf_number].buftype == ''
      end,
    },
    highlights = {
      fill = {
        bg = {
          highlight = 'BufferLineTabSeparator',
          attribute = 'bg',
        },
      },
      pick = {
        fg = {
          highlight = 'Special',
          attribute = 'fg',
        },
      },
      pick_visible = {
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
      error = {
        fg = {
          highlight = 'SnacksNotifierBorderError',
          attribute = 'fg',
        },
      },
      error_visible = {
        fg = {
          highlight = 'SnacksNotifierBorderError',
          attribute = 'fg',
        },
      },
      warning = {
        fg = {
          highlight = 'SnacksNotifierBorderWarn',
          attribute = 'fg',
        },
      },
      warning_visible = {
        fg = {
          highlight = 'SnacksNotifierBorderWarn',
          attribute = 'fg',
        },
      },
    },
  },
}
