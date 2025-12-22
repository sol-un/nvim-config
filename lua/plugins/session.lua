CURRENT = nil

local sort_by_modified_time = function(sessions)
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
  local sorted_session_names = sort_by_modified_time(ms.detected)
  local current_session_name = CURRENT ~= nil and ' (' .. CURRENT .. ')' or ''

  vim.ui.select(sorted_session_names, {
    prompt = 'Select session to ' .. action .. current_session_name,
  }, function(session)
    if session then
      ms[action](session)
    end
  end)
end

local get_session_name = function()
  local name = vim.fn.getcwd()
  local name_normalized = string.gsub(name, '/', '󰿟')
  return name_normalized
end

return {
  { 'notjedi/nvim-rooter.lua', lazy = false, opts = {} },
  {
    'nvim-mini/mini.sessions',
    lazy = false,
    opts = {
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
        '<Leader>Sl',
        function()
          local last_session = require('mini.sessions').get_latest()
          require('mini.sessions').read(last_session)
        end,
        desc = 'Last session',
      },
      {
        '<Leader>SD',
        function()
          read_or_delete 'delete'
        end,
        desc = 'Delete session',
      },
      {
        '<Leader>SF',
        function()
          read_or_delete 'read'
        end,
        desc = 'Select session',
      },
      {
        '<Leader>SS',
        function()
          require('mini.sessions').write(get_session_name())
        end,
        desc = 'Save this session',
      },
    },
  },
}
