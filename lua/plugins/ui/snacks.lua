return {
  'folke/snacks.nvim',
  event = 'VeryLazy',
  ---@type snacks.Config
  opts = {
    notifier = {},
    indent = {},
    scroll = {},
    statuscolumn = { folds = { open = true } },
    bigfile = {},
    picker = {
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
        notifications = { win = { wo = { wrap = true } } },
      },
      layout = {
        fullscreen = true,
      },
    },
  },
}
