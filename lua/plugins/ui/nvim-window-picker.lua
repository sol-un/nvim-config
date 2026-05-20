return {
  's1n7ax/nvim-window-picker',
  opts = {
    hint = 'floating-big-letter',
    show_prompt = false,
  },
  keys = {
    {
      '<Leader>ww',
      function()
        local id = require('window-picker').pick_window()
        if id ~= nil then
          vim.fn.win_gotoid(id)
        end
      end,
      desc = 'Pick window',
    },
  },
}
