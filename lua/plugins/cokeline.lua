local get_color = function(buffer, customNormal)
  local get_hex = require('cokeline.hlgroups').get_hl_attr
  local hl_group

  if not buffer.is_focused then
    if buffer.diagnostics.errors > 0 then
      hl_group = 'SnacksNotifierBorderError'
    elseif buffer.diagnostics.warnings > 0 then
      hl_group = 'SnacksNotifierBorderWarn'
    else
      hl_group = 'Comment'
    end
  end

  if buffer.is_focused then
    if buffer.diagnostics.errors > 0 then
      hl_group = 'DiagnosticError'
    elseif buffer.diagnostics.warnings > 0 then
      hl_group = 'DiagnosticWarn'
    else
      hl_group = 'Normal'
    end
  end

  if hl_group == 'Normal' and customNormal then
    return customNormal
  end

  return get_hex(hl_group, 'fg')
end

return {
  'willothy/nvim-cokeline',
  opts = function()
    local get_hex = require('cokeline.hlgroups').get_hl_attr

    return {
      default_hl = {
        fg = function(buffer)
          return buffer.is_focused and get_hex('Normal', 'fg') or get_hex('ColorColumn', 'fg')
        end,
        bg = function(buffer)
          return buffer.is_focused and get_hex('Normal', 'bg') or get_hex('ColorColumn', 'bg')
        end,
      },
      components = {
        {
          text = function(buffer)
            local cokeline = require 'cokeline.mappings'
            local is_picking = cokeline.is_picking_close() or cokeline.is_picking_focus()

            return is_picking and ' ' .. buffer.pick_letter or ''
          end,
          fg = function()
            return get_hex('Special', 'fg')
          end,
          bold = true,
        },
        {
          text = function(buffer)
            return ' ' .. buffer.devicon.icon
          end,
          fg = function(buffer)
            return get_color(buffer, buffer.devicon.color)
          end,
        },
        {
          text = function(buffer)
            return buffer.unique_prefix
          end,
          fg = get_hex('Comment', 'fg'),
          italic = true,
        },
        {
          text = function(buffer)
            return buffer.filename .. ' '
          end,
          fg = function(buffer)
            return get_color(buffer)
          end,
          bold = function(buffer)
            return buffer.is_focused
          end,
        },
        {
          text = function(buffer)
            return buffer.is_modified and ' ' or ''
          end,
          fg = function(buffer)
            return get_color(buffer)
          end,
        },
        {
          text = function(buffer)
            return buffer.is_readonly and ' ' or ''
          end,
          fg = function(buffer)
            return get_color(buffer)
          end,
        },
      },
      tabs = {
        placement = 'right',
        components = {
          {
            text = function(tabpage)
              local current_tabs = require('cokeline.tabs').get_tabs()
              if tabpage.is_first and #current_tabs == 1 then
                return ''
              end

              return ' ' .. tabpage.number .. ' '
            end,
            fg = function(tabpage)
              return tabpage.is_active and get_hex('Normal', 'fg') or get_hex('ColorColumn', 'fg')
            end,
            bg = function(tabpage)
              return tabpage.is_active and get_hex('Normal', 'bg') or get_hex('ColorColumn', 'bg')
            end,
            bold = function(tabpage)
              return tabpage.is_active
            end,
          },
        },
      },
    }
  end,
}
