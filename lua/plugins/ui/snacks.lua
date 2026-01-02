return {
  'folke/snacks.nvim',
  opts = function(_, opts)
    ---@module 'snacks'
    ---@type snacks.Config
    local config = {
      notifier = {},
      indent = {},
      scroll = {},
      dashboard = { preset = { header = '' }, sections = { { section = 'header' } } },
      statuscolumn = {
        left = { 'git', 'sign' }, -- priority of signs on the left (high to low)
        right = { 'mark', 'fold' }, -- priority of signs on the right (high to low)
        folds = { open = true },
      },
      bigfile = {},
      picker = {
        actions = require('trouble.sources.snacks').actions,
        win = {
          wo = { wrap = true },
          input = {
            keys = {
              ['<C-q>'] = {
                'trouble_open',
                mode = { 'n', 'i' },
              },
            },
          },
        },
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
    }

    return vim.tbl_deep_extend('force', opts or {}, config)
  end,
}
