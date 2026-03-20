vim.api.nvim_create_autocmd('User', {
  desc = 'Update buffers on Neogit events',
  group = vim.api.nvim_create_augroup('neogit_buffers_update', { clear = true }),
  pattern = { 'NeogitBranchCheckout', 'NeogitPullComplete', 'NeogitRebase' },
  callback = function()
    vim.cmd 'set autoread | checktime'
  end,
})

return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
  opts = {
    disable_hint = true,
    kind = 'vsplit',
    -- use https://github.com/rbong/flog-symbols if you don't use Kitty
    graph_style = 'kitty',
    integrations = {
      diffview = true,
      snacks = true,
    },
    signs = {
      item = { '', '' },
      section = { '', '' },
    },
    status = { recent_commit_count = 35 },
    sections = { recent = { folded = false } },
    commit_editor = {
      kind = 'split',
    },
    commit_view = {
      kind = 'split',
    },
    commit_select_view = {
      kind = 'split',
    },
    log_view = {
      kind = 'split',
    },
    reflog_view = {
      kind = 'split',
    },
    stash = {
      kind = 'split',
    },
    refs_view = {
      kind = 'split',
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
  },
  keys = { { '<Leader>gg', '<cmd>Neogit<cr>', desc = 'Neogit' } },
}
