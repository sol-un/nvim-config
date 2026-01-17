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

  { '<Esc><Esc>', '<C-\\><C-n>', desc = 'Exit terminal mode', mode = 't' }, -- This won't work in all terminal emulators/tmux/etc
  { '<C-s>', '<Cmd>w<CR><Esc>', mode = { 'n', 'i', 'v', 's' } }, -- Save
  { '<Leader>q', group = 'Quit' },
  { '<Leader>qq', '<Cmd>confirm qall<CR>', desc = 'Quit' },
  { '<Leader>qr', '<Cmd>restart<CR>', desc = 'Restart', cond = vim.fn.has 'nvim-0.12.0' == 1 },
  {
    '<C-_>', -- this is the same as Ctrl + /, see https://apple.stackexchange.com/questions/24261/how-do-i-send-c-that-is-control-slash-to-the-terminal
    function()
      require('snacks').terminal(nil, { cwd = vim.fn.expand '%:h' })
    end,
    desc = 'Toggle terminal',
  },
  {
    '<C-/>',
    function()
      require('snacks').terminal(nil, { cwd = vim.fn.expand '%:h' })
    end,
    desc = 'Toggle terminal',
  },
  { '<C-/>', '<cmd>close<cr>', desc = 'Hide Terminal', mode = 't' },
  { '<C-_>', '<cmd>close<cr>', desc = 'Hide Terminal', mode = 't' },
  { '<C-h>', '<Backspace>' },
  { '<C-j>', '<cmd>wincmd j<cr>', mode = 't' },
  { '<C-k>', '<cmd>wincmd k<cr>', mode = 't' },
  { '<C-l>', '<cmd>wincmd l<cr>', mode = 't' },

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
  { '<Leader>pi', '<cmd>Lazy home<cr>', desc = 'Plugins' },
  { '<Leader>pm', '<cmd>Mason<cr>', desc = 'Mason' },

  { '<Leader><Tab>', group = 'Tabs' },
  { '<Leader><Tab>o', '<cmd>tabonly<cr>', desc = 'Close Other Tabs' },
  { '<Leader><Tab><Tab>', '<cmd>tabnew<cr>', desc = 'New Tab' },
  { '<Leader><Tab>d', '<cmd>tabclose<cr>', desc = 'Close Tab' },
  { 'gt', '<cmd>tabnext<cr>', desc = 'Next Tab' },
  { 'gT', '<cmd>tabprevious<cr>', desc = 'Previous Tab' },

  { '<Leader>w', group = 'Windows' },
  { '<C-h>', '<C-w><C-h>', desc = 'Move focus to the left window' },
  { '<C-l>', '<C-w><C-l>', desc = 'Move focus to the right window' },
  { '<C-j>', '<C-w><C-j>', desc = 'Move focus to the lower window' },
  { '<C-k>', '<C-w><C-k>', desc = 'Move focus to the upper window' },
  { '<Leader>wv', '<cmd>vsplit<cr>', desc = 'Vertical split' },
  { '<Leader>wd', '<C-W>c', desc = 'Close current window' },
  { '<Leader>wh', '<cmd>split<cr>', desc = 'Horizontal split' },
  { '<Leader>wo', '<cmd>only<cr>', desc = 'Close all other windows' },
  { '<Leader>wJ', '<C-W>J', desc = 'Move window to far bottom' },
  { '<Leader>wK', '<C-W>K', desc = 'Move window to far top' },
  { '<Leader>wH', '<C-W>H', desc = 'Move window to far left' },
  { '<Leader>wL', '<C-W>L', desc = 'Move window to far right' },

  { '<Leader>g', group = 'Git' },
  { '<Leader>S', group = 'Session' },
  { '<Leader>o', group = 'Overseer', icon = '' },
  { '<Leader>a', group = 'AI', icon = '' },
  { '<leader>x', group = 'Trouble', icon = { icon = '󰙅', color = 'red' } },
}
