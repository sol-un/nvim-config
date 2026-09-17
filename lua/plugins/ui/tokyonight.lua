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
        link = 'Comment',
      }
      hl.AnnotatorAnnotationVirtual = {
        link = 'DiagnosticInfo',
      }
      hl.DiffAdd = {
        link = 'NeogitDiffAddHighlight',
      }
      hl.DiffDelete = {
        link = 'NeogitDiffDeleteHighlight',
      }
      hl.GitSignsAddInline = {
        link = 'NeogitDiffAddInline',
      }
      hl.GitSignsDeleteInline = {
        link = 'NeogitDiffDeleteInline',
      }
      hl.DiffviewDiffAddInline = {
        link = 'NeogitDiffAddInline',
      }
      hl.DiffviewDiffDeleteInline = {
        link = 'NeogitDiffDeleteInline',
      }
    end,
  },
}
