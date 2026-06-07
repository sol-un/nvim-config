vim.api.nvim_create_autocmd({ 'BufEnter', 'BufLeave', 'InsertLeave', 'CursorMoved' }, {
  desc = 'Clean up builtin marks',
  callback = function()
    vim.cmd 'delm 0-9[].^<>'
    vim.api.nvim_buf_del_mark(0, '"')
    vim.api.nvim_buf_del_mark(0, "'")
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Start treesitter',
  callback = function(args)
    local buf, filetype = args.buf, args.match
    local language = vim.treesitter.language.get_lang(filetype)

    if not language or not vim.treesitter.language.add(language) then
      return
    end

    vim.treesitter.start(buf, language)
  end,
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  desc = 'Format on save',
  callback = function(ev)
    if not vim.bo.modifiable then
      return
    end

    -- Could have used none-ls and its eslint/eslint_d builtins, but it's kinda buggy and regularly fails with a "failed to decode json" error
    --- @see https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1496
    vim.iter({ 'null-ls', 'eslint' }):each(function(name)
      local client = vim.lsp.get_clients { name = name, bufnr = ev.buf }

      if not vim.tbl_isempty(client) then
        vim.lsp.buf.format { name = name }
      end
    end)
  end,
})
