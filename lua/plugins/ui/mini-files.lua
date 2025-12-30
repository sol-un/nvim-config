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
  config = function(_, opts)
    local set = require('snacks').keymap.set
    set('n', '<Leader>e', function()
      if not require('mini.files').close() then
        require('mini.files').open(vim.api.nvim_buf_get_name(0))
      end
    end, { desc = 'Explorer' })
    set('n', '<Leader>E', function()
      if not require('mini.files').close() then
        require('mini.files').open(vim.uv.cwd())
      end
    end, { desc = 'Explorer (CWD)' })

    require('mini.files').setup(opts)
  end,
  keys = { { '<Leader>e', desc = 'Explorer' }, { '<Leader>E', desc = 'Explorer (CWD)' } },
}
