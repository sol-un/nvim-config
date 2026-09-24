local cyrillic_alphabet = 'ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ'
local cyrillic_labels = 'олджавыфгнрткепимйцуячсшщзьбюАВЫФОЛДЖЙЦУКЕНГШЩЗ'

local is_current_char_cyrillic = function()
  local current_char = unpack(vim.fn.getregion(vim.fn.getpos '.', vim.fn.getpos '.'))

  if current_char == '' then
    return false
  end

  local index = string.find(cyrillic_alphabet, current_char, nil, true)
  return index ~= nil
end

return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  --- @module 'flash'
  --- @type Flash.Config
  --- @diagnostic disable: missing-fields
  opts = { label = { rainbow = { enabled = true } } },
  keys = {
    {
      's',
      function()
        local flash = require 'flash'
        local kde_layout = require 'kde-layout'

        if not is_current_char_cyrillic() then
          flash.jump()
        else
          local previous_layout = kde_layout.get_layout()

          kde_layout.set_layout 'ru'
          flash.jump { labels = cyrillic_labels }
          if previous_layout then
            kde_layout.set_layout(previous_layout)
          end
        end
      end,
      desc = 'Flash',
      mode = { 'n', 'x', 'o' },
    },
    {
      'S',
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash',
      mode = { 'n', 'x', 'o' },
    },
    {
      'R',
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Treesitter search',
      mode = { 'x', 'o' },
    },
    {
      'r',
      function()
        require('flash').remote()
      end,
      desc = 'Remote flash',
      mode = 'o',
    },
  },
}
