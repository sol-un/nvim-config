---@class Utils
local M = {
  ---@return boolean
  is_windows = function()
    local platform = vim.uv.os_uname().sysname
    return platform == 'Windows_NT'
  end,
}

return M
