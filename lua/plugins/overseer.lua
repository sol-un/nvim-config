return {
  'stevearc/overseer.nvim',
  cmd = { 'OverseerRun', 'OverseerToggle' },
  ---@module 'overseer'
  ---@type overseer.SetupOpts
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
      {
        '<Leader>od',
        function()
          local overseer = require 'overseer'
          local tasks = overseer.list_tasks()

          for _, task in ipairs(tasks) do
            overseer.run_action(task, 'dispose')
          end
        end,
        desc = 'Dispose all tasks',
      },
    }
  end,
  keys = '<Leader>o',
}
