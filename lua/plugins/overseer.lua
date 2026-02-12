return {
  'stevearc/overseer.nvim',
  cmd = { 'OverseerRun', 'OverseerToggle' },
  opts = {
    dap = false,
    task_list = {
      direction = 'right',
      keymaps = {
        ['<C-u>'] = 'keymap.scroll_output_up',
        ['<C-d>'] = 'keymap.scroll_output_down',
      },
    },
  },
  init = function()
    require('which-key').add {
      { '<Leader>ot', '<cmd>OverseerToggle! right<cr>', desc = 'Toggle task list' },
      { '<Leader>or', '<cmd>OverseerRun<cr>', desc = 'Run task' },
      { '<Leader>oa', '<cmd>OverseerTaskAction<cr>', desc = 'Task action' },
    }
  end,
  keys = '<Leader>o',
}
