return {
  'sindrets/diffview.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    enhanced_diff_hl = true,
    file_panel = {
      win_config = {
        position = 'bottom',
        height = math.floor(vim.o.lines * 0.3),
      },
    },
  },
  keys = function()
    local set = vim.keymap.set
    set('n', '<Leader>gd', '<cmd>DiffviewOpen<cr>', { desc = 'Diffview Open' })
    set('n', '<Leader>gf', '<cmd>DiffviewFileHistory %<cr>', { desc = 'Git commit history (file)' })
    set('n', '<Leader>gF', '<cmd>DiffviewFileHistory<cr>', { desc = 'Git commit history (repository)' })
  end,
}
