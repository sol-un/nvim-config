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
    local set = vim.keymap.set
    local gs = require 'gitsigns'

    set('n', '<Leader>gp', gs.preview_hunk_inline, { desc = 'Preview Git' })
    set('n', '<Leader>gr', gs.reset_hunk, { desc = 'Reset Git hunk' })
    set('n', '<Leader>gR', gs.reset_buffer, { desc = 'Reset Git buffer' })
    set('n', '<Leader>gs', gs.stage_hunk, { desc = 'Stage/Unstage Git hunk' })
    set('n', '<Leader>gS', gs.stage_buffer, { desc = 'Stage Git buffer' })
    set('n', '<Leader>gb', gs.blame_line, { desc = 'Git blame line' })
    set('n', '<Leader>gB', function()
      gs.blame_line { full = true }
    end, { desc = 'Git blame file' })
    set('n', ']h', function()
      gs.nav_hunk 'next'
    end, { desc = 'Next Git hunk' })
    set('n', '[h', function()
      gs.nav_hunk 'prev'
    end, { desc = 'Previous Git hunk' })

    set('v', '<Leader>gs', function()
      gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'Stage Git hunk' })
    set('v', '<Leader>gr', function()
      gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'Reset Git hunk' })

    set({ 'x', 'o' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'inside Git hunk' })
  end,
}
