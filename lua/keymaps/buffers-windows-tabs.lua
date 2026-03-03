local get_path_by_id = function(buf_id)
  local elements = require('bufferline.commands').get_elements()
  local target = vim.iter(elements.elements):find(function(buf)
    return buf.id == buf_id
  end)

  return target.path
end

require('which-key').add {
  { '<Leader>b', group = 'Buffers' },
  { 'L', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
  { 'H', '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous buffer' },
  {
    '<Leader>bd',
    function()
      require('snacks').bufdelete.delete()
    end,
    desc = 'Close current buffer',
  },
  {
    '<Leader>bo',
    '<cmd>BufferLineCloseOthers<cr>',
    desc = 'Close all other buffers',
  },
  {
    '<Leader>br',
    '<cmd>BufferLineCloseRight<cr>',
    desc = 'Close buffers to the right',
  },
  {
    '<Leader>bl',
    '<cmd>BufferLineCloseLeft<cr>',
    desc = 'Close buffers to the left',
  },
  { '<Leader>bb', '<cmd>BufferLinePick<cr>', desc = 'Focus buffer from tabline' },
  { '<Leader>bD', '<cmd>BufferLinePickClose<cr>', desc = 'Close buffer from tabline' },
  {
    '<Leader>bp',
    '<C-6>',
    desc = 'Focus last buffer',
  },
  {
    '<Leader>bh',
    function()
      require('bufferline.pick').choose_then(function(buf_id)
        vim.cmd.split(get_path_by_id(buf_id))
      end)
    end,
    desc = 'Horizontal split buffer from tabline',
  },
  {
    '<Leader>bv',
    function()
      require('bufferline.pick').choose_then(function(buf_id)
        vim.cmd.vsplit(get_path_by_id(buf_id))
      end)
    end,
    desc = 'Vertical split buffer from tabline',
  },
  {
    '<Leader>by',
    function()
      local path = vim.fn.expand '%:p'
      vim.fn.setreg(vim.v.register, path)
      vim.notify('Copied to clipboard: ' .. path)
    end,
    desc = 'Copy file path',
  },

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
  { '<C-Up>', require('smart-splits').resize_up, desc = 'Increase Window Height' },
  { '<C-Down>', require('smart-splits').resize_down, desc = 'Decrease Window Height' },
  { '<C-Left>', require('smart-splits').resize_left, desc = 'Decrease Window Width' },
  { '<C-Right>', require('smart-splits').resize_right, desc = 'Increase Window Width' },

  { '<Leader><Tab>', group = 'Tabs' },
  { '<Leader><Tab>o', '<cmd>tabonly<cr>', desc = 'Close Other Tabs' },
  { '<Leader><Tab><Tab>', '<cmd>tabnew<cr>', desc = 'New Tab' },
  { '<Leader><Tab>d', '<cmd>tabclose<cr>', desc = 'Close Tab' },
  { 'gt', '<cmd>tabnext<cr>', desc = 'Next Tab' },
  { 'gT', '<cmd>tabprevious<cr>', desc = 'Previous Tab' },
}
