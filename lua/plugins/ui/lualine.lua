local TRUNCATE_LENGTH = 21
local function truncate_string(str)
  if #str < TRUNCATE_LENGTH then
    return str
  end

  return string.sub(str, 1, TRUNCATE_LENGTH - 3) .. '...'
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
          require('utils').get_cwd_name,
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
      lualine_x = {},
      lualine_y = {},
      lualine_z = {
        'location',
      },
    },
  },
}
