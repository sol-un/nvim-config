local prefix = 'gz'

return {
  {
    'nvim-mini/mini.surround',
    event = 'VeryLazy',
    opts = {
      n_lines = 999,
      mappings = {
        add = prefix .. 'a',
        delete = prefix .. 'd',
        find = prefix .. 'f',
        find_left = prefix .. 'F',
        highlight = prefix .. 'h',
        replace = prefix .. 'r',
      },
    },
    init = function()
      require('which-key').add { prefix, group = 'Surround', icon = '󰘦 ' }
    end,
  },
  { 'nvim-mini/mini.pairs', opts = {} },
}
