return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  config = function(_, opts)
    require('tokyonight').setup(opts)
    vim.cmd.colorscheme 'tokyonight'
  end,
  --- @module 'tokyonight'
  --- @class tokyonight.Config
  --- @diagnostic disable: missing-fields
  opts = {
    style = 'moon',
    on_highlights = function(hl)
      hl.LspCodeLens = {
        fg = '#636DA6',
        italic = true,
      }
    end,
  },
}
