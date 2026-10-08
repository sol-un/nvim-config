--- Derived from mini.sessions' own state, so deletions done elsewhere (e.g. on worktree removal) are reflected
--- @return string|nil
local current_session = function()
  return vim.v.this_session ~= '' and vim.fn.fnamemodify(vim.v.this_session, ':t') or nil
end

local names_by_modify_time = function(sessions)
  local session_metas = vim
    .iter(vim.tbl_values(sessions))
    :filter(function(session)
      return session.name ~= current_session()
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

--- @param action "read"|"delete"
local read_or_delete = function(action)
  local ms = require 'mini.sessions'
  local sorted_session_names = names_by_modify_time(ms.detected)
  local current = current_session()
  local current_session_name = current ~= nil and ' (current: ' .. current .. ')' or ''

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
          read = function()
            vim.api.nvim_exec_autocmds('User', {
              pattern = 'SessionRead',
            })

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
          require('mini.sessions').read(session_name)
        end,
        desc = 'Create & switch to',
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
