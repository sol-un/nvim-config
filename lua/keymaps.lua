local set = require('snacks').keymap.set
local picker = require('snacks').picker

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

-- Pickers
set('n', '<Leader>f<CR>', picker.resume, { desc = 'Resume previous search' })
set('n', '<Leader>fl', picker.lines, { desc = 'Find lines' })
set('n', '<Leader>,', picker.buffers, { desc = 'Find buffers' })
set('n', '<Leader>fc', picker.grep_word, { desc = 'Find word under cursor' })
set('n', '<Leader>fC', picker.commands, { desc = 'Find commands' })
set('n', '<Leader>fF', function()
  picker.files { hidden = true, ignored = true }
end, { desc = 'Find all files' })
set('n', '<Leader>fh', picker.help, { desc = 'Find help' })
set('n', '<Leader>fk', picker.keymaps, { desc = 'Find keymaps' })
set('n', '<Leader>fm', picker.man, { desc = 'Find man' })
set('n', '<Leader>fn', picker.notifications, { desc = 'Find notifications' })
set('n', '<Leader>fo', picker.recent, { desc = 'Find old files' })
set('n', '<Leader>fO', function()
  picker.recent { filter = { cwd = true } }
end, {
  desc = 'Find old files (cwd)',
})
set('n', '<Leader>fp', picker.projects, { desc = 'Find projects' })
set('n', '<Leader>fr', picker.registers, { desc = 'Find registers' })
set('n', '<Leader>fs', picker.smart, { desc = 'Find buffers/recent/files' })

set('n', '<Leader>ff', function()
  require('snacks').picker.files {
    hidden = vim.tbl_get((vim.uv or vim.loop).fs_stat '.git' or {}, 'type') == 'directory',
  }
end, { desc = 'Find files' })

if vim.fn.executable 'rg' == 1 then
  set('n', '<Leader>fw', picker.grep, { desc = 'Find words' })
  set('n', '<Leader>fW', function()
    picker.grep { hidden = true, ignored = true }
  end, { desc = 'Find words in all files' })
end

set('n', '<Leader>fu', picker.undo, { desc = 'Find undo history' })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
