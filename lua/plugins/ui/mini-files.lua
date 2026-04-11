vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesActionRename',
  callback = function(event)
    require('snacks').rename.on_rename_file(event.data.from, event.data.to)
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesActionDelete',
  callback = function(event)
    require('snacks').bufdelete.delete { file = event.data.from, force = true }
  end,
})

return {
  'nvim-mini/mini.files',
  opts = {
    windows = {
      preview = true,
      max_number = 2,
      width_focus = math.floor(vim.o.columns * 0.29),
      width_preview = math.floor(vim.o.columns * 0.69),
    },
  },
  init = function()
    require('snacks').keymap.set('n', '<Leader>e', function()
      require('mini.files').close()
    end, { ft = 'minifiles' })
  end,
  keys = {
    {
      '<Leader>e',
      function()
        require('mini.files').open(vim.fn.expand '%:p')
      end,
      desc = 'Explorer',
    },
    {
      '<Leader>E',
      function()
        require('mini.files').open(nil, false)
      end,
      desc = 'Explorer (CWD)',
    },
  },
}
