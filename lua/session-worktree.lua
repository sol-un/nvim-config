-- Sessions backed by git worktrees: creating one adds a worktree, deleting its session removes it

--- @param path string
local normalize = function(path)
  return vim.fs.normalize(vim.fn.fnamemodify(path, ':p'))
end

--- @param args string[]
--- @param cwd string
--- @return boolean ok, string output stdout on success, stderr otherwise
local git = function(args, cwd)
  local result = vim.system(vim.list_extend({ 'git' }, args), { cwd = cwd, text = true }):wait()
  local ok = result.code == 0
  return ok, vim.trim(ok and result.stdout or result.stderr)
end

--- Working directory recorded in a session file (the `cd` line written by `curdir`)
--- @param path string
--- @return string|nil
local session_cwd = function(path)
  for line in io.lines(path) do
    local dir = line:match '^cd (.+)$'

    if dir then
      return normalize(vim.fn.expand(dir))
    end
  end
end

--- Write a session for `dir` without making it the current one: `MiniSessions.write` would switch to
--- it and capture this project's buffers, while a bare `cd` is all a fresh worktree session needs
--- @param name string
--- @param dir string
local write_session = function(name, dir)
  local ms = require 'mini.sessions'
  local file = vim.fs.joinpath(normalize(ms.config.directory), name)
  vim.fn.writefile({ 'cd ' .. vim.fn.fnameescape(vim.fn.fnamemodify(dir, ':~')) }, file)

  -- `read`/`delete`/`select` re-detect sessions, but the pickers read `detected` directly
  ms.detected[name] = { modify_time = vim.fn.getftime(file), name = name, path = file, type = 'global' }
end

local M = {}

--- Prompt for a branch and a location, add a worktree for it next to the current one and write its
--- session. The branch is checked out if it exists, otherwise created from the current HEAD.
M.create = function()
  local ok, toplevel = git({ 'rev-parse', '--show-toplevel' }, vim.fn.getcwd())

  if not ok then
    vim.notify('Not in a git repository', vim.log.levels.WARN)
    return
  end

  vim.ui.input({ prompt = 'Worktree branch: ' }, function(branch)
    if not branch or vim.trim(branch) == '' then
      return
    end

    branch = vim.trim(branch)
    local default = vim.fs.joinpath(vim.fs.dirname(toplevel), (branch:gsub('/', '-')))

    vim.ui.input({ prompt = 'Worktree path: ', default = default, completion = 'dir' }, function(input)
      if not input or vim.trim(input) == '' then
        return
      end

      local dir = normalize(vim.trim(input))
      local name = vim.fs.basename(dir)

      if require('mini.sessions').detected[name] then
        vim.notify(('Session %q already exists'):format(name), vim.log.levels.WARN)
        return
      end

      local exists = git({ 'show-ref', '--verify', '--quiet', 'refs/heads/' .. branch }, toplevel)
      local add = exists and { 'worktree', 'add', dir, branch } or { 'worktree', 'add', '-b', branch, dir }
      local added, err = git(add, toplevel)

      if not added then
        vim.notify(err, vim.log.levels.ERROR)
        return
      end

      write_session(name, dir)
      vim.notify(('Created worktree and session %q'):format(name))
    end)
  end)
end

--- `pre` delete hook: remove the session's worktree if it is a linked one (never the main checkout).
--- Errors abort the deletion, so the session survives a worktree that couldn't be removed.
--- @param session { path: string }
M.remove = function(session)
  local dir = session_cwd(session.path)

  if not dir or vim.fn.isdirectory(dir) == 0 then
    return
  end

  local ok, dirs = git({ 'rev-parse', '--path-format=absolute', '--git-dir', '--git-common-dir' }, dir)
  local git_dir, common_dir = unpack(vim.split(dirs, '\n'))

  if not ok or git_dir == common_dir then
    return
  end

  -- Run from the shared git dir: the worktree itself is about to disappear
  local removed, err = git({ 'worktree', 'remove', dir }, common_dir)

  if not removed then
    if vim.fn.confirm(err .. '\nRemove anyway?', '&Yes\n&No', 2) ~= 1 then
      error('Kept worktree and session for ' .. dir, 0)
    end

    removed, err = git({ 'worktree', 'remove', '--force', dir }, common_dir)

    if not removed then
      error(err, 0)
    end
  end
end

return M
