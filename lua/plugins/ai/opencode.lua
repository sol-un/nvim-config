local prefix = '<Leader>a'

return {
  'sudo-tee/opencode.nvim',
  cond = true,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  ---@module 'opencode'
  ---@type OpencodeConfig
  opts = {
    default_mode = 'plan',
    default_global_keymaps = false,
    ui = {
      enable_treesitter_markdown = false,
      picker = {
        snacks_layout = {
          preset = 'vscode',
          fullscreen = false,
        },
      },
      input = { text = { wrap = true } },
      questions = {
        use_vim_ui_select = true,
      },
      output = {
        filetype = 'markdown',
        compact_assistant_headers = true,
        tools = {
          show_reasoning_output = false,
        },
      },
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
  keys = {
    {
      prefix .. 'c',
      function()
        require('opencode.api').open_input_new_session()
      end,
      desc = 'New session',
    },
    {
      prefix .. 'h',
      function()
        require('opencode.api').select_session()
      end,
      desc = 'Select session',
    },
    {
      prefix .. 't',
      function()
        require('opencode.api').timeline()
      end,
      desc = 'Timeline picker',
      ft = { 'opencode', 'opencode_output' },
    },
    {
      prefix .. 'm',
      '<cmd>Opencode models<cr>',
      desc = 'Select model',
      ft = { 'opencode', 'opencode_output' },
    },
  },
}
