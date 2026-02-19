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

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Start treesitter',
  pattern = '*',
  callback = function()
    pcall(vim.treesitter.start)
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
