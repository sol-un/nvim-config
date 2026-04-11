require('which-key').add {
  { '<Esc>', '<cmd>nohlsearch<CR>' }, -- Clear highlights on search when pressing <Esc> in normal mode

  -- Better up/down on wrapped lines
  {
    mode = { 'n', 'x' },
    expr = true,
    silent = true,
    { 'j', "v:count == 0 ? 'gj' : 'j'" },
    { 'k', "v:count == 0 ? 'gk' : 'k'" },
  },

  -- Better indenting (stay in visual mode)
  {
    mode = 'v',
    { '<', '<gv' },
    { '>', '>gv' },
  },

  -- Auto-close pairs
  {
    mode = 'i',
    { '`', '``<left>' },
    { '"', '""<left>' },
    { '(', '()<left>' },
    { '[', '[]<left>' },
    { '{', '{}<left>' },
    { '<', '<><left>' },
  },

  -- Saving, quitting
  { '<C-s>', '<Cmd>w<CR><Esc>', mode = { 'n', 'i', 'v', 's' }, desc = 'Save' },
  { '<Leader>q', group = 'Quit' },
  { '<Leader>qq', '<Cmd>confirm qall<CR>', desc = 'Quit' },

  -- Terminal
  {
    desc = 'Toggle terminal',
    {
      '<C-/>',
      function()
        require('snacks').terminal.toggle(nil, { cwd = vim.fn.expand '%:h' })
      end,
    },
    {
      '<C-_>', -- this is the same as Ctrl + /, see https://apple.stackexchange.com/questions/24261/how-do-i-send-c-that-is-control-slash-to-the-terminal
      function()
        require('snacks').terminal.toggle(nil, { cwd = vim.fn.expand '%:h' })
      end,
    },
  },
  {
    mode = 't',
    { '<Esc><Esc>', '<C-\\><C-n>', desc = 'Exit terminal mode' }, -- This won't work in all terminal emulators/tmux/etc
    { '<C-/>', '<cmd>close<cr>', desc = 'Hide Terminal' },
    { '<C-_>', '<cmd>close<cr>', desc = 'Hide Terminal' },
    { '<C-h>', '<Backspace>' },
    { '<C-j>', '<cmd>wincmd j<cr>' },
    { '<C-k>', '<cmd>wincmd k<cr>' },
    { '<C-l>', '<cmd>wincmd l<cr>' },
  },

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
