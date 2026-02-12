return {
  'MagicDuck/grug-far.nvim',
  opts = {
    folding = {
      enabled = false,
    },
    engines = {
      ripgrep = {
        placeholders = {
          paths = 'e.g. /foo/bar or a built-in provider (<buflist>, <buflist-cwd>, <qflist>, <loclist>)',
        },
        defaults = {
          paths = '<buflist>',
        },
      },
    },
  },
  keys = {
    { '<Leader>fr', '<cmd>GrugFar<cr>', desc = 'Search/replace' },
  },
}
