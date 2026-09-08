local prefix = '<Leader>a'

return {
  'chpeters/annotator.nvim',
  event = 'VeryLazy',
  --- @module "annotator"
  --- @type AnnotatorConfig
  opts = {
    storage = 'state',
    mappings = false,
    display = {
      kinds = {
        comment = { sign_text = '󱓩' },
        suggest = { sign_text = '󱘓' },
        delete = { sign_text = '󱘕' },
      },
    },
  },
  keys = {
    { prefix .. 'a', '<cmd>AnnotatorAdd<cr>', desc = 'Add/edit annotation' },
    {
      prefix .. 'a',
      function()
        require('annotator.annotate').visual_selection()
      end,
      desc = 'Add/edit annotation',
      mode = 'x',
    },
    { prefix .. 'd', '<cmd>AnnotatorDelete<cr>', desc = 'Delete annotation' },
    { prefix .. 's', '<cmd>AnnotatorSuggest<cr>', desc = 'Suggest changes' },
    {
      prefix .. 's',
      function()
        require('annotator.annotate').suggest_visual()
      end,
      desc = 'Suggest changes',
      mode = 'x',
    },
    { prefix .. 'l', '<cmd>AnnotatorList<cr>', desc = 'List annotations' },
    { prefix .. 'c', '<cmd>AnnotatorClear<cr>', desc = 'Clear all annotations' },
    { prefix .. 'E', '<cmd>AnnotatorExport<cr>', desc = 'Copy to clipboard' },
  },
}
