vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  desc = 'Open last session on start',
  callback = function()
    vim.defer_fn(function()
      local last_session = require('mini.sessions').get_latest()
      require('mini.sessions').read(last_session)
    end, 0)
  end,
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave' }, {
  desc = 'Clean up builtin marks',
  callback = function()
    vim.cmd 'delm 0-9[].^'
    vim.cmd [[delm \"]]
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Highlight references of the word under cursor and clear highlights on cursor move',
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local is_highlight_supported = client and client:supports_method('textDocument/documentHighlight', event.buf)

    if is_highlight_supported then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufWrite', 'InsertLeave', 'TextChanged' }, {
  desc = 'Automatic linting',
  callback = function()
    local lint = require 'lint'

    if vim.bo.modifiable then
      local client = vim.lsp.get_clients({ bufnr = 0 })[1] or {}
      lint.try_lint(nil, { cwd = client.root_dir })
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  desc = 'Format on save',
  callback = function()
    local conform = require 'conform'

    if vim.bo.modifiable then
      conform.format { quiet = true }
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Start treesitter',
  pattern = { '*' },
  callback = function()
    local filetype = vim.bo.filetype
    if filetype and filetype ~= '' then
      local success = pcall(function()
        vim.treesitter.start()
      end)
      if not success then
        return
      end
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Wrap and check for spell in text filetypes',
  pattern = { 'text', 'plaintex', 'typst', 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
