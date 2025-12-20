return {
  'harrisoncramer/gitlab.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
  build = function()
    require('gitlab.server').build(true)
  end,
  opts = {
    reviewer_settings = {
      jump_with_no_diagnostics = true,
      diffview = {
        imply_local = true,
      },
    },
    keymaps = {
      discussion_tree = {
        toggle_sort_method = 'gSt',
        toggle_date_format = 'gDt',
        add_emoji = 'gEa',
        delete_emoji = 'gEd',
      },
      popup = {
        perform_action = '<C-s>',
        discard_changes = '<C-k>',
      },
    },
    discussion_tree = {
      position = 'left',
      keep_current_open = true,
      draft_mode = true,
      tree_type = 'by_file_name',
    },
  },
}
