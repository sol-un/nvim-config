-- The code syncing creation/removal of Neogit worktrees with sessions

local wrap_worktree_remove = function()
  -- Neogit emits `NeogitWorktreeCreate` but nothing on deletion, so wrap the low-level remove
  -- (used by the worktree popup's delete action, including its `--force` retry) to emit our own.
  -- Named differently from a hypothetical upstream `NeogitWorktreeDelete` to avoid double-firing.
  local worktree = require 'neogit.lib.git.worktree'
  local remove = worktree.remove

  worktree.remove = function(path, args)
    local ok = remove(path, args)

    if ok then
      vim.api.nvim_exec_autocmds('User', {
        pattern = 'NeogitWorktreeRemoved',
        modeline = false,
        data = { path = vim.fs.normalize(vim.fn.fnamemodify(path, ':p')) },
      })
    end

    return ok
  end
end

--- @param path string
local normalize = function(path)
  return vim.fs.normalize(vim.fn.fnamemodify(path, ':p'))
end

--- Working directory recorded in a detected session (the `cd` line written by `curdir`)
--- @param name string
--- @return string|nil
local session_cwd = function(name)
  local session = require('mini.sessions').detected[name]

  if not session then
    return nil
  end

  for line in io.lines(session.path) do
    local dir = line:match '^cd (.+)$'

    if dir then
      return normalize(vim.fn.expand(dir))
    end
  end
end

local group = vim.api.nvim_create_augroup('neogit_worktree_sessions', { clear = true })

vim.api.nvim_create_autocmd('User', {
  desc = 'Create a session for a new Neogit worktree, staying in the current one',
  group = group,
  pattern = 'NeogitWorktreeCreate',
  callback = function(args)
    -- Resolve now: the path may be relative to the cwd we are about to leave
    local path = normalize(args.data.new_cwd)
    local old_cwd = args.data.old_cwd
    local name = vim.fs.basename(path)
    local existing = session_cwd(name)

    if existing and existing ~= path then
      vim.notify(('Session %q already exists for %s, not creating one for the worktree'):format(name, existing), vim.log.levels.WARN)
    elseif not existing then
      -- Written by hand instead of `MiniSessions.write`, which would make it the current session and
      -- capture this project's buffers. A bare `cd` is all a fresh worktree session needs.
      local ms = require 'mini.sessions'
      local file = vim.fs.joinpath(normalize(ms.config.directory), name)
      vim.fn.writefile({ 'cd ' .. vim.fn.fnameescape(vim.fn.fnamemodify(path, ':~')) }, file)

      -- `read`/`delete`/`select` re-detect sessions, but the pickers here read `detected` directly
      ms.detected[name] = { modify_time = vim.fn.getftime(file), name = name, path = file, type = 'global' }
    end

    -- Undo Neogit's switch into the worktree (queued after its own scheduled chdir), so the current
    -- session keeps its cwd and doesn't get autowritten with the worktree's
    vim.schedule(function()
      local status = require 'neogit.buffers.status'

      if status.is_open() then
        status.instance():chdir(old_cwd)
      else
        vim.api.nvim_set_current_dir(old_cwd)
      end
    end)
  end,
})

vim.api.nvim_create_autocmd('User', {
  desc = 'Delete the session of a removed Neogit worktree',
  group = group,
  pattern = 'NeogitWorktreeRemoved',
  callback = function(args)
    local name = vim.fs.basename(args.data.path)

    -- Same-named sessions of unrelated projects are left alone
    if session_cwd(name) ~= args.data.path then
      return
    end

    -- Also clears `vim.v.this_session` if it was the current one
    require('mini.sessions').delete(name, { force = true, verbose = false })
  end,
})

local M = {
  wrap_worktree_remove = wrap_worktree_remove,
}

return M
