return {
  'folke/snacks.nvim',
  event = 'VeryLazy',
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    notifier = {},
    indent = {},
    scroll = {},
    statuscolumn = { folds = { open = true } },
    bigfile = {},
    picker = {
      win = { wo = { wrap = true } },
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          layout = {
            fullscreen = false,
            preview = 'main',
          },
        },
        select = { layout = { fullscreen = false } },
        lines = { layout = { fullscreen = false } },
        files = {
          hidden = true,
          ignored = true,
        },
        grep = { hidden = true },
        grep_word = { hidden = true },
        recent = { hidden = true, ignored = true },
      },
      layout = {
        fullscreen = true,
      },
    },
  },
}
