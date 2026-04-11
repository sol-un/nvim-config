---@type string|nil
local CURRENT = nil

local names_by_modify_time = function(sessions)
  local session_metas = vim
    .iter(vim.tbl_values(sessions))
    :filter(function(session)
      return session.name ~= CURRENT
    end)
    :totable()

  table.sort(session_metas, function(a, b)
    return a.modify_time > b.modify_time
  end)

  return vim
    .iter(session_metas)
    :map(function(session)
      return session.name
    end)
    :totable()
end

---@param action "read"|"delete"
local read_or_delete = function(action)
  local ms = require 'mini.sessions'
  local sorted_session_names = names_by_modify_time(ms.detected)
  local current_session_name = CURRENT ~= nil and ' (current: ' .. CURRENT .. ')' or ''

  vim.ui.select(sorted_session_names, {
    prompt = 'Select session to ' .. action .. current_session_name,
  }, function(session)
    if session then
      ms[action](session)
    end
  end)
end

return {
  { 'notjedi/nvim-rooter.lua', lazy = false, opts = {} },
  {
    'nvim-mini/mini.sessions',
    lazy = false,
    opts = {
      autoread = true,
      autowrite = true,
      hooks = {
        post = {
          read = function(current)
            CURRENT = current['name']
            vim.cmd ':Rooter'
          end,
        },
      },
    },
    keys = {
      {
        '<Leader>sd',
        function()
          read_or_delete 'delete'
        end,
        desc = 'Delete',
      },
      {
        '<Leader>sf',
        function()
          read_or_delete 'read'
        end,
        desc = 'Select',
      },
      {
        '<Leader>ss',
        function()
          local session_name = require('utils').get_cwd_name()
          require('mini.sessions').write(session_name)
        end,
        desc = 'Save',
      },
      {
        '<Leader>qr',
        function()
          -- Preserves current session
          require('mini.sessions').restart()
        end,
        desc = 'Restart',
      },
    },
  },
}
