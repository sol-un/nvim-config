vim.g.clock_visible = false

local function linters()
  local current_linters = require('lint')._resolve_linter_by_ft(vim.bo.filetype)

  return table.concat(current_linters, ', ')
end

local function formatters()
  local current_formatters = require('conform').list_formatters(0)

  local formatter_names = vim
    .iter(current_formatters)
    :map(function(formatter)
      return formatter.name
    end)
    :totable()
  return table.concat(formatter_names, ', ')
end

local function macro()
  local reg = vim.fn.reg_recording()
  return #reg ~= 0 and '@' .. reg or ''
end

local function truncate_string(str)
  if #str > 25 then
    return string.sub(str, 1, 22) .. '...'
  end

  return str
end

local function cwd()
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
      lualine_a = { 'mode' },
      lualine_b = {
        { 'branch', icon = '', fmt = truncate_string },
        { cwd, icon = '', fmt = truncate_string },
      },
      lualine_c = { { macro, icon = '' } },
      lualine_x = {},
      lualine_y = {
        { 'lsp_status', icon = '', symbols = { done = '', separator = ', ', spinner = {} } },
        linters,
        formatters,
      },
      lualine_z = {
        'location',
        {
          'datetime',
          icon = '',
          style = '%H:%M',
          cond = function()
            return vim.g.clock_visible
          end,
        },
      },
    },
  },
  init = function()
    require('snacks').toggle
      .new({
        id = 'clock_visible',
        name = 'Clock',
        get = function()
          return vim.g.clock_visible
        end,
        set = function(value)
          vim.g.clock_visible = value
        end,
      })
      :map '<Leader>Tc'
  end,
}
