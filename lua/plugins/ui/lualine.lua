local function get_linters()
  local linters = require('lint')._resolve_linter_by_ft(vim.bo.filetype)

  return table.concat(linters, ', ')
end

local function get_formatters()
  local formatters = require('conform').list_formatters(0)

  local formatter_names = vim
    .iter(formatters)
    :map(function(formatter)
      return formatter.name
    end)
    :totable()
  return table.concat(formatter_names, ', ')
end

local function get_macro()
  local reg = vim.fn.reg_recording()
  return #reg ~= 0 and '@' .. reg or ''
end

local function get_cwd()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      globalstatus = true,
    },
    sections = {
      lualine_b = {
        { 'branch', icon = '' },
        'diff',
        'diagnostics',
      },
      lualine_c = { { get_cwd, icon = '' }, { get_macro, icon = '' } },
      lualine_x = {},
      lualine_y = {
        { 'lsp_status', icon = '', symbols = { done = '', separator = ', ', spinner = {} } },
        get_linters,
        get_formatters,
      },
      lualine_z = {
        'location',
        { 'datetime', icon = '', style = '%H:%M' },
      },
    },
  },
}
