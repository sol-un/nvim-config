return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '│' },
      topdelete = { text = '│' },
      changedelete = { text = '│' },
      untracked = { text = '┊' },
    },
    signs_staged = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '│' },
      topdelete = { text = '│' },
      changedelete = { text = '│' },
      untracked = { text = '┊' },
    },
    attach_to_untracked = true,
  },
  config = function(_, opts)
    local gitsigns = require 'gitsigns'

    require('which-key').add {
      { '<Leader>gp', gitsigns.preview_hunk_inline, desc = 'Preview Git' },
      { '<Leader>gr', gitsigns.reset_hunk, desc = 'Reset Git hunk' },
      { '<Leader>gR', gitsigns.reset_buffer, desc = 'Reset Git buffer' },
      { '<Leader>gs', gitsigns.stage_hunk, desc = 'Stage/Unstage Git hunk' },
      { '<Leader>gS', gitsigns.stage_buffer, desc = 'Stage Git buffer' },
      { '<Leader>gb', gitsigns.blame, desc = 'Git blame' },
      {
        ']h',
        function()
          gitsigns.nav_hunk 'next'
        end,
        desc = 'Next Git hunk',
      },
      {
        '[h',
        function()
          gitsigns.nav_hunk 'prev'
        end,
        desc = 'Previous Git hunk',
      },
      {
        '<Leader>gs',
        function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end,
        desc = 'Stage Git hunk',
        mode = 'v',
      },
      {
        '<Leader>gr',
        function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end,
        desc = 'Reset Git hunk',
        mode = 'v',
      },
      { 'ih', ':<C-U>Gitsigns select_hunk<CR>', desc = 'inside Git hunk', mode = { 'x', 'o' } },
    }

    gitsigns.setup(opts)
  end,
}
