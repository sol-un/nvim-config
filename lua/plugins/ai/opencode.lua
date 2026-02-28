return {
  'sudo-tee/opencode.nvim',
  cond = true,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    default_mode = 'plan',
    default_global_keymaps = false,
    ui = {
      picker = {
        ---@module "snacks"
        ---@type snacks.picker.layout.Config | nil
        snacks_layout = {
          hidden = { 'preview' },
          fullscreen = false,
          layout = {
            backdrop = false,
            row = 1,
            width = 0.4,
            min_width = 80,
            height = 0.4,
            border = 'none',
            box = 'vertical',
            {
              win = 'input',
              height = 1,
              border = true,
              title = '{title} {live} {flags}',
              title_pos = 'center',
            },
            { win = 'list', border = 'hpad' },
            { win = 'preview', title = '{preview}', border = true },
          },
        },
      },
      input = { text = { wrap = true } },
    },
    context = {
      enabled = false,
      cursor_data = {
        enabled = false,
      },
      diagnostics = {
        info = false,
        warn = false,
        error = false,
      },
      current_file = {
        enabled = false,
      },
      selection = {
        enabled = false,
      },
    },
    keymap = {
      input_window = {
        ['<C-s>'] = { 'submit_input_prompt', mode = { 'n', 'i' } },
        ['<C-c>'] = { 'cancel' },
        ['@'] = { 'mention_file', mode = 'i' },
        ['~'] = { 'mention', mode = 'i' },
      },
      session_picker = {
        rename_session = { '<M-r>' },
        delete_session = { '<M-d>' },
        new_session = { '<M-n>' },
      },
      timeline_picker = {
        undo = { '<M-u>', mode = { 'i', 'n' } },
        fork = { '<M-f>', mode = { 'i', 'n' } },
      },
      history_picker = {
        delete_entry = { '<M-d>', mode = { 'i', 'n' } },
        clear_all = { '<M-x>', mode = { 'i', 'n' } },
      },
    },
  },
  keys = '<Leader>a',
  init = function()
    local set = require('snacks').keymap.set

    set('n', '<Leader>ac', function()
      require('opencode.api').open_input_new_session()
    end, { desc = 'New session' })
    set('n', '<Leader>ah', function()
      require('opencode.api').select_session()
    end, { desc = 'Select session' })
    set('n', '<Leader>at', function()
      require('opencode.api').timeline()
    end, { desc = 'Timeline picker', ft = { 'opencode', 'opencode_output' } })
    set('n', '<Leader>am', '<cmd>Opencode models<cr>', { desc = 'Select model', ft = { 'opencode', 'opencode_output' } })
  end,
}
