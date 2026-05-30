return {
  {
    'dlyongemallo/diffview-plus.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    ---@module 'diffview.config'
    ---@type DiffviewConfig
    ---@diagnostic disable: missing-fields
    opts = {
      enhanced_diff_hl = true,
      diffopt = { algorithm = 'histogram' },
      show_help_hints = false,
      show_root_path = false,
      hide_merge_artifacts = true,
      clean_up_buffers = true,
      auto_close_on_empty = true,
      default_args = {
        DiffviewOpen = { '--imply-local' },
      },
      persist_selections = { enabled = true },
      file_panel = {
        mark_placement = 'sign_column',
        win_config = {
          position = 'bottom',
          height = math.floor(vim.o.lines * 0.3),
        },
      },
      view = {
        one_sided_layout = 'raw',
        merge_tool = {
          layout = 'diff4_mixed',
          disable_diagnostics = true,
          winbar_info = true,
        },
        cycle_layouts = {
          merge_tool = { 'diff4_mixed', 'diff3_mixed', 'diff3_horizontal', 'diff1_plain' },
        },
      },
      status_icons = {
        ['A'] = '', -- Added
        ['?'] = '', -- Untracked
        ['M'] = '', -- Modified
        ['R'] = '', -- Renamed
        ['C'] = '', -- Copied
        ['T'] = '', -- Type changed
        ['U'] = '', -- Unmerged
        ['X'] = '', -- Unknown
        ['D'] = '', -- Deleted
        ['B'] = '', -- Broken
        ['!'] = '', -- Ignored
      },
    },
    keys = {
      { '<Leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diffview Open' },
      { '<Leader>gf', '<cmd>DiffviewFileHistory %<cr>', desc = 'Git commit history (file)' },
      { '<Leader>gF', '<cmd>DiffviewFileHistory<cr>', desc = 'Git commit history (repository)' },
    },
  },
}
