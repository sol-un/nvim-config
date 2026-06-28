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
    if not vim.bo.modifiable or not vim.g.format_on_save_enabled then
      return
    end

    local client = vim.lsp.get_clients { name = 'null-ls', bufnr = ev.buf }

    if not vim.tbl_isempty(client) then
      vim.lsp.buf.format { name = 'null-ls' }
    end
  end,
})
