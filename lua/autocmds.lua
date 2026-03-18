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
    if not language then
      return
    end

    if not vim.treesitter.language.add(language) then
      return
    end
    vim.treesitter.start(buf, language)
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufWrite', 'InsertLeave', 'TextChanged' }, {
  desc = 'Lint',
  callback = function()
    local lint = require 'lint'

    if vim.bo.modifiable then
      local client = vim.lsp.get_clients({ bufnr = 0 })[1] or {}
      lint.try_lint(nil, { cwd = client.root_dir })
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  desc = 'Format',
  callback = function()
    local conform = require 'conform'

    if vim.bo.modifiable then
      conform.format { quiet = true }
    end
  end,
})
