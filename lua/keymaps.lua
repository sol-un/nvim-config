local set = require('snacks').keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
set('n', '<leader>x', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Save
set({ 'n', 'i', 'v', 's' }, '<C-s>', '<Cmd>w<CR><Esc>')

-- Quit
set('n', '<Leader>qq', '<Cmd>confirm qall<CR>', { desc = 'Quit' })

-- Tabs
set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

set('n', '<Leader><Tab>o', '<cmd>tabonly<cr>', { desc = 'Close Other Tabs' })
set('n', '<Leader><Tab><Tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
set('n', '<Leader><Tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
set('n', 'gt', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
set('n', 'gT', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

-- Windows
set('n', '<Leader>wv', '<cmd>vsplit<cr>', { desc = 'Vertical split' })
set('n', '<Leader>wd', '<C-W>c', { desc = 'Close current window' })
set('n', '<Leader>wh', '<cmd>split<cr>', { desc = 'Horizontal split' })
set('n', '<Leader>wo', '<cmd>only<cr>', { desc = 'Close all other windows' })
set('n', '<Leader>wJ', '<C-W>J', { desc = 'Move window to far bottom' })
set('n', '<Leader>wK', '<C-W>K', { desc = 'Move window to far top' })
set('n', '<Leader>wH', '<C-W>H', { desc = 'Move window to far left' })
set('n', '<Leader>wL', '<C-W>L', { desc = 'Move window to far right' })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
