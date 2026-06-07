local keymaps = {
  { lhs = '<Leader>l', rhs = function() end, desc = 'LeetCode' },
  { lhs = '<Leader>lc', rhs = '<cmd>Leet console<cr>', desc = 'Console' },
  { lhs = '<Leader>lh', rhs = '<cmd>Leet hints<cr>', desc = 'Hints' },
  { lhs = '<Leader>ls', rhs = '<cmd>Leet submit<cr>', desc = 'Submit' },
  { lhs = '<Leader>lt', rhs = '<cmd>Leet test<cr>', desc = 'Run tests' },
  { lhs = '<Leader>ld', rhs = '<cmd>Leet desc<cr>', desc = 'Toggle description' },
  { lhs = '<Leader>lr', rhs = '<cmd>Leet reset<cr>', desc = 'Reset' },
  { lhs = '<Leader>lo', rhs = '<cmd>Leet open<cr>', desc = 'View in browser' },
  { lhs = '<Leader>lq', rhs = '<cmd>Leet exit<cr>', desc = 'Quit' },
}

return {
  'kawre/leetcode.nvim',
  cmd = 'Leet',
  dependencies = {
    'folke/snacks.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  --- @module 'leetcode'
  --- @type lc.UserConfig
  --- @diagnostic disable: missing-fields
  opts = {
    lang = 'typescript',
    plugins = {
      non_standalone = true,
    },
    hooks = {
      enter = function()
        vim.iter(keymaps):each(function(keymap)
          require('snacks').keymap.set('n', keymap.lhs, keymap.rhs, { desc = keymap.desc })
        end)
      end,
      leave = function()
        vim.iter(keymaps):each(function(keymap)
          require('snacks').keymap.del('n', keymap.lhs)
        end)
      end,
    },
  },
}
