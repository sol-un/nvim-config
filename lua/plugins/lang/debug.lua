return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'theHamsta/nvim-dap-virtual-text', opts = {} },

      {
        'rcarriga/nvim-dap-ui',
        dependencies = {
          'nvim-neotest/nvim-nio',
        },
        opts = {
          icons = { expanded = '', collapsed = '', current_frame = '*' },
          controls = {
            icons = {
              pause = '',
              play = '',
              step_into = '',
              step_over = '',
              step_out = '',
              step_back = '',
              run_last = '',
              terminate = '',
              disconnect = '',
            },
          },
        },
      },
    },
    keys = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      require('which-key').add {
        { '<Leader>d', group = 'Debug', icon = '' },
      }

      return {
        { '<leader>db', dap.toggle_breakpoint, desc = 'Toggle breakpoint' },
        { '<leader>dB', dap.clear_breakpoints, desc = 'Clear breakpoints' },
        { '<leader>dp', dap.pause, desc = 'Pause' },
        { '<leader>dR', dap.repl.toggle, desc = 'Toggle REPL' },
        { '<leader>ds', dap.run_to_cursor, desc = 'Run to cursor' },
        { '<leader>dq', dap.close, desc = 'Close session' },
        { '<leader>dh', require('dap.ui.widgets').hover, desc = 'Hover' },
        {
          '<leader>dE',
          function()
            vim.ui.input({ prompt = 'Expression: ' }, function(expr)
              if expr then
                dapui.eval(expr, { enter = true })
              end
            end)
          end,
          desc = 'Evaluate input',
        },
        { '<leader>dr', dap.restart_frame, desc = 'Restart' },
        { '<leader>do', dap.step_over, desc = 'Step over' },
        { '<leader>di', dap.step_into, desc = 'Step into' },
        { '<leader>dO', dap.step_out, desc = 'Step out' },
        { '<leader>du', dapui.toggle, desc = 'Toggle UI' },
        { '<leader>dc', dap.continue, desc = 'Continue' },
        { '<leader>dQ', dap.terminate, desc = 'Terminate session' },
        {
          '<leader>dC',
          function()
            vim.ui.input({ prompt = 'Condition: ' }, function(condition)
              if condition then
                require('dap').set_breakpoint(condition)
              end
            end)
          end,
          desc = 'Conditional breakpoint',
        },
      }
    end,
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      local breakpoint_icons = { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '󰛿', Stopped = '󰁕' }
      for type, icon in pairs(breakpoint_icons) do
        local tp = 'Dap' .. type
        local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
        vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
      end

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end,
  },
}
