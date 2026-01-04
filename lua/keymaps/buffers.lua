---@param side 'left' | 'right'
local delete_buffers_to_side = function(side)
  local buffers = require 'cokeline.buffers'

  vim
    .iter(buffers.get_visible())
    :filter(function(buffer)
      local current_index = buffers.get_current().index

      if side == 'right' then
        return buffer.index > current_index
      else
        return buffer.index < current_index
      end
    end)
    :each(function(buffer)
      require('snacks').bufdelete.delete(buffer.number)
    end)
end

require('which-key').add {
  { '<Leader>b', group = 'Buffers' },
  { 'L', '<Plug>(cokeline-focus-next)', desc = 'Next buffer' },
  { 'H', '<Plug>(cokeline-focus-prev)', desc = 'Previous buffer' },
  {
    '<Leader>bd',
    function()
      require('snacks').bufdelete.delete()
    end,
    desc = 'Close current buffer',
  },
  {
    '<Leader>bo',
    function()
      require('snacks').bufdelete.other()
    end,
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
    function()
      delete_buffers_to_side 'right'
    end,
    desc = 'Close buffers to the right',
  },
  {
    '<Leader>bl',
    function()
      delete_buffers_to_side 'left'
    end,
    desc = 'Close buffers to the left',
  },
  { '<Leader>bb', '<Plug>(cokeline-pick-focus)', desc = 'Focus buffer from tabline' },
  { '<Leader>bD', '<Plug>(cokeline-pick-close)', desc = 'Close buffer from tabline' },
  {
    '<Leader>bp',
    function()
      local last = require('cokeline.history'):last()
      if last ~= nil then
        require('cokeline.mappings').by_index('focus', last.index)
      else
        vim.notify('Buffer history is empty', 'info')
      end
    end,
    desc = 'Focus last buffer',
  },
  {
    '<Leader>bh',
    function()
      vim.g.cokeline_is_picking = true
      require('cokeline.mappings').pick(function(buf)
        vim.cmd.split()
        require('cokeline.mappings').by_index('focus', buf.index)
        vim.g.cokeline_is_picking = false
      end)
    end,
    desc = 'Horizontal split buffer from tabline',
  },
  {
    '<Leader>bv',
    function()
      vim.g.cokeline_is_picking = true
      require('cokeline.mappings').pick(function(buf)
        vim.cmd.vsplit()
        require('cokeline.mappings').by_index('focus', buf.index)
        vim.g.cokeline_is_picking = false
      end)
    end,
    desc = 'Vertical split buffer from tabline',
  },
}
