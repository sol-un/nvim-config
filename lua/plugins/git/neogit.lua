local fetch = vim.schedule_wrap(function()
  require('plenary.job')
    :new({
      command = 'git',
      args = { 'fetch', '--all' },
      cwd = vim.fn.getcwd(),
      on_exit = function(j, return_val)
        if return_val ~= 0 then
          vim.notify('Git fetch failed: ' .. table.concat(j:stderr_result(), '\n'), vim.log.levels.ERROR)
        end
      end,
    })
    :start()
end)

vim.api.nvim_create_autocmd('User', {
  desc = 'Update buffers on Neogit events',
  group = vim.api.nvim_create_augroup('neogit_buffers_update', { clear = true }),
  pattern = { 'NeogitBranchCheckout', 'NeogitPullComplete' },
  callback = function()
    vim.cmd 'set autoread | checktime'
  end,
})

vim.api.nvim_create_autocmd('User', {
  desc = 'Fetch all on Negit open',
  group = vim.api.nvim_create_augroup('neogit_fetch_on_open', { clear = true }),
  pattern = 'NeogitStatusRefreshed',
  callback = fetch,
})

return {
  'NeogitOrg/neogit',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
  cmd = 'Neogit',
  branch = 'master',
  opts = {
    kind = 'tab',
    graph_style = 'unicode',
    integrations = {
      diffview = true,
      snacks = true,
    },
    signs = {
      item = { '', '' },
      section = { '', '' },
    },
    mappings = {
      commit_editor = {
        ['<c-s>'] = 'Submit',
        ['<c-k>'] = 'Abort',
      },
      commit_editor_I = {
        ['<c-s>'] = 'Submit',
        ['<c-k>'] = 'Abort',
      },
      rebase_editor = {
        ['<c-s>'] = 'Submit',
        ['<c-k>'] = 'Abort',
      },
      rebase_editor_I = {
        ['<c-s>'] = 'Submit',
        ['<c-k>'] = 'Abort',
      },
    },
    status = { recent_commit_count = 30 },
    sections = { recent = { folded = false } },
    commit_editor = {
      kind = 'vsplit',
    },
    commit_select_view = {
      kind = 'vsplit',
    },
    log_view = {
      kind = 'vsplit',
    },
    reflog_view = {
      kind = 'vsplit',
    },
    stash = {
      kind = 'vsplit',
    },
    refs_view = {
      kind = 'vsplit',
    },
  },
  keys = { { '<Leader>gg', '<cmd>Neogit<cr>', desc = 'Neogit' } },
}
