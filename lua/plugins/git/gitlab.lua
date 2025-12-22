local prefix = '<Leader>gl'

return {
  {
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
        global = {
          add_assignee = prefix .. 'aa',
          delete_assignee = prefix .. 'ad',
          add_label = prefix .. 'la',
          delete_label = prefix .. 'ld',
          add_reviewer = prefix .. 'ra',
          delete_reviewer = prefix .. 'rd',
          approve = prefix .. 'A', -- Approve MR
          revoke = prefix .. 'R', -- Revoke MR approval
          merge = prefix .. 'M', -- Merge the feature branch to the target branch and close MR
          create_mr = prefix .. 'C', -- Create a new MR for currently checked-out feature branch
          choose_merge_request = prefix .. 'c', -- Chose MR for review (if necessary check out the feature branch)
          start_review = prefix .. 'S', -- Start review for the currently checked-out branch
          summary = prefix .. 's', -- Show the editable summary of the MR
          copy_mr_url = prefix .. 'u', -- Copy the URL of the MR to the system clipboard
          open_in_browser = prefix .. 'o', -- Openthe URL of the MR in the default Internet browser
          create_note = prefix .. 'n', -- Create a note (comment not linked to a specific line)
          pipeline = prefix .. 'p', -- Show the pipeline status
          toggle_discussions = prefix .. 'd', -- Toggle the discussions window
          toggle_draft_mode = prefix .. 'D', -- Toggle between draft mode (comments posted as drafts) and live mode (comments are posted immediately)
          publish_all_drafts = prefix .. 'P', -- Publish all draft comments/notes
        },
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
  },
}
