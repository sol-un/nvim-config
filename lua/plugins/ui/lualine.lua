vim.g.lang_features_visible = false
vim.g.clock_visible = false

local function truncate_string(str)
  local MAX_LENGTH = 21

  if #str > MAX_LENGTH then
    return string.sub(str, 1, MAX_LENGTH - 3) .. '...'
  end

  return str
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
        {
          function()
            return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
          end,
          icon = '',
          fmt = truncate_string,
        },
      },
      lualine_c = {
        { 'navic', color_correction = 'dynamic' },
        {
          function()
            local reg = vim.fn.reg_recording()
            return #reg ~= 0 and '@' .. reg or ''
          end,
          icon = '',
        },
      },
      lualine_x = { { 'overseer', unique = true } },
      lualine_y = {
        {
          'lsp_status',
          icon = '',
          symbols = { done = '', separator = ', ', spinner = {} },
          cond = function()
            return vim.g.lang_features_visible
          end,
        },
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
