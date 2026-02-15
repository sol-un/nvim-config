return {
  'esmuellert/codediff.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  cmd = 'CodeDiff',
  opts = {
    explorer = {
      position = 'bottom',
      height = math.floor(vim.o.lines * 0.3),
      view_mode = 'tree',
    },
    history = {
      height = math.floor(vim.o.lines * 0.3),
    },
  },
  keys = {
    { '<Leader>gd', '<cmd>CodeDiff<cr>', desc = 'Diffview Open' },
    { '<Leader>gf', '<cmd>CodeDiff history %<cr>', desc = 'Git commit history (file)' },
    { '<Leader>gF', '<cmd>CodeDiff history<cr>', desc = 'Git commit history (repository)' },
  },
}
