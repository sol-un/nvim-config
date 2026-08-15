vim.api.nvim_create_autocmd('User', {
  desc = 'Update buffers on Neogit events',
  group = vim.api.nvim_create_augroup('neogit_buffers_update', { clear = true }),
  pattern = { 'NeogitBranchCheckout', 'NeogitPullComplete', 'NeogitRebase', 'NeogitStash' },
  callback = function()
    vim.cmd.checktime()
  end,
})

return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'dlyongemallo/diffview-plus.nvim',
  },
  --- @module 'neogit'
  --- @type NeogitConfig
  --- @diagnostic disable: missing-fields
  opts = {
    disable_hint = true,
    prompt_amend_commit = false,
    kind = 'vsplit',
    -- install https://github.com/rbong/flog-symbols if you don't use kitty
    graph_style = require('utils').is_kitty() and 'kitty' or 'unicode',
    auto_show_console = false,
    console_timeout = math.huge,
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
