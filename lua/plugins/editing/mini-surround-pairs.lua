local prefix = 'gz'

return {
  {
    'nvim-mini/mini.surround',
    event = 'VeryLazy',
    opts = {
      n_lines = 999,
      mappings = {
        add = prefix .. 'a', -- Add surrounding in Normal and Visual modes
        delete = prefix .. 'd', -- Delete surrounding
        replace = prefix .. 'r', -- Replace surrounding
      },
    },
    init = function()
      require('which-key').add { prefix, group = 'Surround', icon = '󰘦 ' }
    end,
  },
  { 'nvim-mini/mini.pairs', opts = {} },
}
