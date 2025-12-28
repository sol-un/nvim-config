return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts_extend = { 'plugins.git.keymaps.lua' },
  opts = {
    enhanced_diff_hl = true,
    file_panel = {
      win_config = {
        position = 'bottom',
        height = math.floor(vim.o.lines * 0.3),
      },
    },
  },
  keys = {
    { '<Leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diffview Open' },
    { '<Leader>gf', '<cmd>DiffviewFileHistory %<cr>', desc = 'Git commit history (file)' },
    { '<Leader>gF', '<cmd>DiffviewFileHistory<cr>', desc = 'Git commit history (repository)' },
  },
}
