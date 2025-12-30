local prefix = '<Leader>d'

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
    keys = prefix,
    init = function()
      require('which-key').add {
        {
          { '<Leader>d', group = 'Debug', icon = '' },
          {
            prefix .. 'b',
            function()
              require('dap').toggle_breakpoint()
            end,
            desc = 'Toggle breakpoint',
          },
          {
            prefix .. 'B',
            function()
              require('dap').clear_breakpoints()
            end,
            desc = 'Clear breakpoints',
          },
          {
            prefix .. 'p',
            function()
              require('dap').pause()
            end,
            desc = 'Pause',
          },
          {
            prefix .. 'R',
            function()
              require('dap').repl.toggle()
            end,
            desc = 'Toggle REPL',
          },
          {
            prefix .. 's',
            function()
              require('dap').run_to_cursor()
            end,
            desc = 'Run to cursor',
          },
          {
            prefix .. 'q',
            function()
              require('dap').close()
            end,
            desc = 'Close session',
          },
          {
            prefix .. 'h',
            function()
              require('dap.ui.widgets').hover()
            end,
            desc = 'Hover',
          },
          {
            prefix .. 'E',
            function()
              vim.ui.input({ prompt = 'Expression: ' }, function(expr)
                if expr then
                  require('dapui').eval(expr, { enter = true })
                end
              end)
            end,
            desc = 'Evaluate input',
          },
          {
            prefix .. 'r',
            function()
              require('dap').restart_frame()
            end,
            desc = 'Restart',
          },
          {
            prefix .. 'o',
            function()
              require('dap').step_over()
            end,
            desc = 'Step over',
          },
          {
            prefix .. 'i',
            function()
              require('dap').step_into()
            end,
            desc = 'Step into',
          },
          {
            prefix .. 'O',
            function()
              require('dap').step_out()
            end,
            desc = 'Step out',
          },
          {
            prefix .. 'u',
            function()
              require('dapui').toggle()
            end,
            desc = 'Toggle UI',
          },
          {
            prefix .. 'c',
            function()
              require('dap').continue()
            end,
            desc = 'Continue',
          },
          {
            prefix .. 'Q',
            function()
              require('dap').terminate()
            end,
            desc = 'Terminate session',
          },
          {
            prefix .. 'C',
            function()
              vim.ui.input({ prompt = 'Condition: ' }, function(condition)
                if condition then
                  require('dap').set_breakpoint(condition)
                end
              end)
            end,
            desc = 'Conditional breakpoint',
          },
        },
      }
    end,
  },
}
