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
  keys = function()
    local wk = require 'which-key'
    local gs = require 'gitsigns'

    wk.add {
      { '<Leader>gp', gs.preview_hunk_inline, desc = 'Preview Git' },
      { '<Leader>gr', gs.reset_hunk, desc = 'Reset Git hunk' },
      { '<Leader>gR', gs.reset_buffer, desc = 'Reset Git buffer' },
      { '<Leader>gs', gs.stage_hunk, desc = 'Stage/Unstage Git hunk' },
      { '<Leader>gS', gs.stage_buffer, desc = 'Stage Git buffer' },
      { '<Leader>gb', gs.blame_line, desc = 'Git blame line' },
      {
        '<Leader>gB',
        function()
          gs.blame_line { full = true }
        end,
        desc = 'Git blame file',
      },
      {
        ']h',
        function()
          gs.nav_hunk 'next'
        end,
        desc = 'Next Git hunk',
      },
      {
        '[h',
        function()
          gs.nav_hunk 'prev'
        end,
        desc = 'Previous Git hunk',
      },
      {
        '<Leader>gs',
        function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end,
        desc = 'Stage Git hunk',
        mode = 'v',
      },
      {
        '<Leader>gr',
        function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end,
        desc = 'Reset Git hunk',
        mode = 'v',
      },
      { 'ih', ':<C-U>Gitsigns select_hunk<CR>', desc = 'inside Git hunk', mode = { 'x', 'o' } },
    }
  end,
}
