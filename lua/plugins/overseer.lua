local dispose_all = function()
  local overseer = require 'overseer'
  local tasks = overseer.list_tasks()

  for _, task in ipairs(tasks) do
    overseer.run_action(task, 'dispose')
  end
end

vim.api.nvim_create_autocmd('ExitPre', {
  desc = 'Dispose all tasks',
  callback = function()
    dispose_all()
  end,
})

return {
  'stevearc/overseer.nvim',
  cmd = { 'OverseerRun', 'OverseerToggle' },
  --- @module 'overseer'
  --- @type overseer.SetupOpts
  --- @diagnostic disable: missing-fields
  opts = {
    dap = false,
    task_list = {
      direction = 'right',
      keymaps = {
        ['k'] = "<CMD>lua require('overseer.task_list.sidebar').get():jump(-1)<CR>",
        ['j'] = "<CMD>lua require('overseer.task_list.sidebar').get():jump(1)<CR>",
        ['<C-d>'] = { 'keymap.run_action', opts = { action = 'dispose' }, desc = 'Dispose task' },
        ['<C-r>'] = { 'keymap.run_action', opts = { action = 'restart' }, desc = 'Restart task' },
        ['<C-q>'] = { 'keymap.run_action', opts = { action = 'set quickfix diagnostics' }, desc = 'Send results to quickfix' },
        ['<C-w>'] = { 'keymap.run_action', opts = { action = 'watch' }, desc = 'Watch' },
        ['<C-u>'] = { 'keymap.run_action', opts = { action = 'unwatch' }, desc = 'Unwatch' },
      },
    },
  },
  init = function()
    require('which-key').add {
      { '<Leader>ot', '<cmd>OverseerToggle!<cr>', desc = 'Toggle task list' },
      { '<Leader>or', '<cmd>OverseerRun<cr>', desc = 'Run task' },
      {
        '<Leader>od',
        function()
          dispose_all()
        end,
        desc = 'Dispose all tasks',
      },
    }
  end,
  keys = '<Leader>o',
}
