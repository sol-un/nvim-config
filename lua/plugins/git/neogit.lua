local group = vim.api.nvim_create_augroup('neogit_buffers_update', { clear = true })

vim.api.nvim_create_autocmd('User', {
  desc = 'Update buffers on Neogit events',
  group = group,
  pattern = { 'NeogitBranchCheckout', 'NeogitPullComplete', 'NeogitRebase', 'NeogitStash', 'NeogitReset' },
  callback = function()
    vim.cmd.checktime()
  end,
})

--- Files git hands to GIT_EDITOR/GIT_SEQUENCE_EDITOR, which Neogit opens as buffers
local editor_files = {
  COMMIT_EDITMSG = true,
  MERGE_MSG = true,
  TAG_EDITMSG = true,
  EDIT_DESCRIPTION = true,
  ['git-rebase-todo'] = true,
}

vim.api.nvim_create_autocmd('User', {
  desc = 'Wipe leftover git editor buffers after Neogit closes its editor',
  group = group,
  pattern = 'NeogitEditorClosed',
  callback = function()
    -- Neogit's `Buffer.from_name` reuses whatever buffer `bufnr()` finds, and
    -- `Buffer.create` then writes the file contents into it. An aborted commit can leave
    -- that buffer behind unloaded, so the next commit's write makes Neovim re-read the
    -- file from inside an autocmd window, which fails with `E5108: Failed to load buffer`.
    -- Wiping the leftovers keeps every commit starting from a fresh, loaded buffer.
    --
    -- Deferred: the event is emitted from the buffer's own `on_detach`, while it is still
    -- unloading, so the wipe cannot happen synchronously.
    vim.schedule(function()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local name = vim.api.nvim_buf_get_name(buf)

        if not vim.api.nvim_buf_is_loaded(buf) and name:match '/%.git/' and editor_files[vim.fs.basename(name)] then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end
    end)
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
    console_timeout = 1000 * 60 * 5,
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
