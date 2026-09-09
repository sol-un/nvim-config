---@type fun(annotation: AnnotatorAnnotation): string
local comment_normalizer = function(annotation)
  local start_line = annotation['start_line']
  local end_line = annotation['end_line']
  local is_multiline = start_line ~= end_line

  local lines = is_multiline and string.format('lines %s to %s', start_line, end_line) or string.format('line %s', start_line)
  local meta = annotation['relative_path'] .. ' ' .. lines

  return '- ' .. meta .. ': ' .. annotation['comment']
end

---@type fun(annotation: AnnotatorAnnotation): string
local suggest_normalizer = function(annotation)
  local start_line = annotation['start_line']
  local end_line = annotation['end_line']
  local is_multiline = start_line ~= end_line

  local lines = is_multiline and string.format('lines %s to %s', start_line, end_line) or string.format('line %s', start_line)
  local meta = annotation['relative_path'] .. ' ' .. lines

  return '- ' .. meta .. ': ' .. 'Suggested replacement:\n```\n' .. annotation['replacement'] .. '\n```'
end

---@type { [AnnotatorAnnotationKind]: function }
local normalizers_map = {
  comment = comment_normalizer,
  suggest = suggest_normalizer,
}

---@param annotation AnnotatorAnnotation
local normalize_annotation = function(annotation)
  return normalizers_map[annotation['kind']](annotation)
end

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
      },
    },
    hooks = {
      export = function(ctx)
        local normalized = vim.iter(ctx.annotations):map(normalize_annotation):totable()
        vim.fn.setreg('+', table.concat(normalized, '\n'))

        ctx.clear_exported()
        ctx.notify('Copied annotations', 'info')
      end,
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
