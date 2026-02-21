return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd.colorscheme 'tokyonight'
    end,
    ---@module 'tokyonight'
    ---@class tokyonight.Config
    opts = {
      style = 'moon',
      on_highlights = function(hl, c)
        hl.LspCodeLens = {
          fg = '#636DA6',
          italic = true,
        }
      end,
    },
  },
}
