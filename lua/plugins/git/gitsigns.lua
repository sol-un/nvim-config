return {
  'lewis6991/gitsigns.nvim',
  opts = {
    numhl = true,
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
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 0,
    },
  },
  config = function(_, opts)
    local gitsigns = require 'gitsigns'

    require('which-key').add {
      { '<Leader>gp', gitsigns.preview_hunk, desc = 'Preview diff' },
      { '<Leader>gr', gitsigns.reset_hunk, desc = 'Reset hunk' },
      {
        '<Leader>gr',
        function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end,
        desc = 'Reset hunk',
        mode = 'v',
      },
      { '<Leader>gR', gitsigns.reset_buffer, desc = 'Reset buffer' },
      { '<Leader>gs', gitsigns.stage_hunk, desc = 'Stage/Unstage hunk' },
      {
        '<Leader>gs',
        function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end,
        desc = 'Stage hunk',
        mode = 'v',
      },
      {
        '<Leader>gS',
        function()
          if #gitsigns.get_hunks(0) > 0 then
            gitsigns.stage_buffer()
          else
            gitsigns.reset_buffer_index()
          end
        end,
        desc = 'Stage/Unstage buffer',
      },
      { '<Leader>gb', gitsigns.blame, desc = 'Blame file' },
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
      { 'ih', ':<C-U>Gitsigns select_hunk<CR>', desc = 'inside Git hunk', mode = { 'x', 'o' } },
    }

    gitsigns.setup(opts)
  end,
}
