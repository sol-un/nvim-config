require('which-key').add {
  { '<Esc>', '<cmd>nohlsearch<CR>' }, -- Clear highlights on search when pressing <Esc> in normal mode

  -- Better up/down on wrapped lines
  { 'j', "v:count == 0 ? 'gj' : 'j'", expr = true, silent = true, mode = { 'n', 'x' } },
  { 'k', "v:count == 0 ? 'gk' : 'k'", expr = true, silent = true, mode = { 'n', 'x' } },

  -- Better indenting (stay in visual mode)
  { '<', '<gv', mode = 'v' },
  { '>', '>gv', mode = 'v' },

  -- Auto-close pairs
  { '`', '``<left>', mode = 'i' },
  { '"', '""<left>', mode = 'i' },
  { '(', '()<left>', mode = 'i' },
  { '[', '[]<left>', mode = 'i' },
  { '{', '{}<left>', mode = 'i' },
  { '<', '<><left>', mode = 'i' },

  -- Terminal
  { '<Esc><Esc>', '<C-\\><C-n>', desc = 'Exit terminal mode', mode = 't' }, -- This won't work in all terminal emulators/tmux/etc
  { '<C-s>', '<Cmd>w<CR><Esc>', mode = { 'n', 'i', 'v', 's' } }, -- Save
  { '<Leader>q', group = 'Quit' },
  { '<Leader>qq', '<Cmd>confirm qall<CR>', desc = 'Quit' },
  { '<Leader>qr', '<Cmd>restart<CR>', desc = 'Restart', cond = vim.fn.has 'nvim-0.12.0' == 1 },
  {
    '<C-_>', -- this is the same as Ctrl + /, see https://apple.stackexchange.com/questions/24261/how-do-i-send-c-that-is-control-slash-to-the-terminal
    function()
      require('snacks').terminal.toggle(nil, { cwd = vim.fn.expand '%:h' })
    end,
    desc = 'Toggle terminal',
  },
  {
    '<C-/>',
    function()
      require('snacks').terminal.toggle(nil, { cwd = vim.fn.expand '%:h' })
    end,
    desc = 'Toggle terminal',
  },
  { '<C-/>', '<cmd>close<cr>', desc = 'Hide Terminal', mode = 't' },
  { '<C-_>', '<cmd>close<cr>', desc = 'Hide Terminal', mode = 't' },
  { '<C-h>', '<Backspace>' },
  { '<C-j>', '<cmd>wincmd j<cr>', mode = 't' },
  { '<C-k>', '<cmd>wincmd k<cr>', mode = 't' },
  { '<C-l>', '<cmd>wincmd l<cr>', mode = 't' },

  -- Navigation
  {
    '[e',
    function()
      vim.diagnostic.jump { count = -vim.v.count1, severity = 1 }
    end,
    desc = 'Previous error',
  },
  {
    ']e',
    function()
      vim.diagnostic.jump { count = vim.v.count1, severity = 1 }
    end,
    desc = 'Next error',
  },
  {
    '[w',
    function()
      vim.diagnostic.jump { count = -vim.v.count1, severity = 2 }
    end,
    desc = 'Previous warning',
  },
  {
    ']w',
    function()
      vim.diagnostic.jump { count = vim.v.count1, severity = 2 }
    end,
    desc = 'Next warning',
  },

  { '<Leader>p', group = 'Packages', icon = '' },
  { '<Leader>pl', '<cmd>Lazy home<cr>', desc = 'Lazy' },
  { '<Leader>pm', '<cmd>Mason<cr>', desc = 'Mason' },

  { '<Leader>g', group = 'Git' },
  { '<Leader>s', group = 'Session' },
  { '<Leader>o', group = 'Overseer', icon = '' },
  { '<Leader>a', group = 'AI', icon = '' },
  { '<leader>x', group = 'Trouble', icon = { icon = '󰙅', color = 'red' } },
  { '<leader>r', group = 'Search & replace', mode = { 'n', 'v' }, icon = { icon = '󰛔', color = 'blue' } },
}
