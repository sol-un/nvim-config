--- @type fun (bufnr: number): boolean
local is_postavki = function(bufnr)
  local sln = vim.fs.find('Postavki.sln', {
    path = vim.api.nvim_buf_get_name(bufnr),
    upward = true,
  })
  return #sln > 0
end

local resharper_cleanup = function()
  local path = vim.fn.expand '%:p'
  local notify_id = 'resharper_cleanup_' .. path
  local timer = vim.uv.new_timer()

  if timer then
    timer:start(
      0,
      100,
      vim.schedule_wrap(function()
        vim.notify('Cleaning up...', nil, {
          id = notify_id,
          replace = notify_id,
          title = 'ReSharper',
        })
      end)
    )
  end

  vim.system(
    { 'jb', 'cleanupcode', path },
    { text = true },
    --- @param out vim.SystemCompleted
    vim.schedule_wrap(function(out)
      if out.code ~= 0 then
        return
      end

      if timer then
        timer:stop()
        timer:close()
      end

      vim.cmd.checktime()
      vim.notify('Done cleaning up', nil, {
        id = notify_id,
        replace = notify_id,
        title = 'ReSharper',
      })
    end)
  )
end

local ft = { 'csproj', 'cs' }

return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'csharpier',
        'netcoredbg',
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        cs = function(bufnr)
          return is_postavki(bufnr) and { 'csharpier' } or {}
        end,
        xml = { 'xmllint' },
      },
    },
  },
  -- NOTE: easy-dotnet.nvim sets up LSP and DAP for C# internally, so these require no explicit setup
  {
    'GustavEikaas/easy-dotnet.nvim',
    cmd = 'Dotnet',
    ft = ft,
    --- @module "easy-dotnet"
    --- @type easy-dotnet.Options
    --- @diagnostic disable: missing-fields
    opts = {
      -- NOTE: prefer neotest with vstest, it's much more efficient and convenient
      test_runner = {
        auto_start_testrunner = false,
      },
    },
    init = function()
      require('which-key').add {
        {
          '<Leader>.',
          group = '.NET',
          icon = { icon = '󰪮', color = 'blue' },
        },
      }
    end,
    keys = {
      {
        '<Leader>.f',
        resharper_cleanup,
        ft = ft,
      },
    },
  },
  {
    'mfussenegger/nvim-dap',
    opts = function()
      local dap = require 'dap'

      -- Enables previewing complex variables like System.Guid
      require('easy-dotnet.netcoredbg').register_dap_variables_viewer()
      -- Correct netcoredbg exe path for Windows
      local win_cmd = vim.fn.stdpath 'data' .. '\\mason\\packages\\netcoredbg\\netcoredbg\\netcoredbg.exe'

      dap.adapters.netcoredbg = {
        type = 'executable',
        command = require('utils').is_windows() and win_cmd or 'netcoredbg',
        args = { '--interpreter=vscode' },
      }
    end,
  },
  {
    'nvim-neotest/neotest',
    dependencies = { 'nsidorenco/neotest-vstest' },
    opts = function(_, opts)
      table.insert(opts.adapters or {}, require 'neotest-vstest')
    end,
  },
}
