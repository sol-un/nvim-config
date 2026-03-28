---@class Utils
local M = {
  ---@return boolean
  is_windows = function()
    local platform = vim.uv.os_uname().sysname
    return platform == 'Windows_NT'
  end,
  ---@return boolean
  is_wsl = function()
    return vim.fn.isdirectory '/mnt/c' == 1
  end,
}

return M
