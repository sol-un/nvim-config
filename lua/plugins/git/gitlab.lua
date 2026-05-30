local gitlab_prefix = '<Leader>gl'

return {
  {
    'harrisoncramer/gitlab.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'dlyongemallo/diffview.nvim',
    },
    build = function()
      require('gitlab.server').build(true)
    end,
    ---@module 'gitlab'
    ---@type Settings
    opts = {
      keymaps = {
        global = {
          disable_all = true,
        },
        popup = {
          perform_action = '<C-s>',
          discard_changes = '<C-k>',
        },
        reviewer_settings = {
          jump_with_no_diagnostics = true,
          diffview = {
            imply_local = true,
          },
        },
        discussion_tree = {
          toggle_sort_method = 'gSt',
          toggle_date_format = 'gDt',
          add_emoji = 'gEa',
          delete_emoji = 'gEd',
        },
      },
      discussion_tree = {
        auto_open = true,
        position = 'left',
        keep_current_open = true,
        draft_mode = true,
        tree_type = 'by_file_name',
      },
    },
    keys = { { gitlab_prefix, desc = 'GitLab' } },
    init = function()
      require('which-key').add {
        { gitlab_prefix, group = 'GitLab', icon = { icon = '', color = 'orange' } },
        {
          gitlab_prefix .. 'aa',
          function()
            require('gitlab').add_assignee()
          end,
          desc = 'Add assignee',
        },
        {
          gitlab_prefix .. 'ad',
          function()
            require('gitlab').delete_assignee()
          end,
          desc = 'Delete assignee',
        },
        {
          gitlab_prefix .. 'la',
          function()
            require('gitlab').add_label()
          end,
          desc = 'Add label',
        },
        {
          gitlab_prefix .. 'ld',
          function()
            require('gitlab').delete_label()
          end,
          desc = 'Delete label',
        },
        {
          gitlab_prefix .. 'ra',
          function()
            require('gitlab').add_reviewer()
          end,
          desc = 'Add reviewer',
        },
        {
          gitlab_prefix .. 'rd',
          function()
            require('gitlab').delete_reviewer()
          end,
          desc = 'Delete reviewer',
        },
        {
          gitlab_prefix .. 'A',
          function()
            require('gitlab').approve()
          end,
          desc = 'Approve',
        },
        {
          gitlab_prefix .. 'R',
          function()
            require('gitlab').revoke()
          end,
          desc = 'Revoke',
        },
        {
          gitlab_prefix .. 'M',
          function()
            require('gitlab').merge()
          end,
          desc = 'Merge',
        },
        {
          gitlab_prefix .. 'C',
          function()
            require('gitlab').create_mr()
          end,
          desc = 'Create mr',
        },
        {
          gitlab_prefix .. 'c',
          function()
            require('gitlab').choose_merge_request()
          end,
          desc = 'Choose merge request',
        },
        {
          gitlab_prefix .. 'S',
          function()
            require('gitlab').review()
          end,
          desc = 'Start review',
        },
        {
          gitlab_prefix .. 's',
          function()
            require('gitlab').summary()
          end,
          desc = 'Summary',
        },
        {
          gitlab_prefix .. 'u',
          function()
            require('gitlab').copy_mr_url()
          end,
          desc = 'Copy mr url',
        },
        {
          gitlab_prefix .. 'o',
          function()
            require('gitlab').open_in_browser()
          end,
          desc = 'Open in browser',
        },
        {
          gitlab_prefix .. 'n',
          function()
            require('gitlab').create_note()
          end,
          desc = 'Create note',
        },
        {
          gitlab_prefix .. 'p',
          function()
            require('gitlab').pipeline()
          end,
          desc = 'Pipeline',
        },
        {
          gitlab_prefix .. 'd',
          function()
            require('gitlab').toggle_discussions()
          end,
          desc = 'Toggle discussions',
        },
        {
          gitlab_prefix .. 'D',
          function()
            require('gitlab').toggle_draft_mode()
          end,
          desc = 'Toggle draft mode',
        },
        {
          gitlab_prefix .. 'P',
          function()
            require('gitlab').publish_all_drafts()
          end,
          desc = 'Publish all drafts',
        },
      }
    end,
  },
}
