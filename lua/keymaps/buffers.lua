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
    '<Leader>bA',
    function()
      require('snacks').bufdelete.all()
    end,
    desc = 'Close all buffers',
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
      vim.fn.setreg(vim.v.register, vim.fn.expand '%:p')
    end,
    desc = 'Copy current file path',
  },
}
