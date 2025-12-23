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
