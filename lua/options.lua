local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.winborder = 'rounded'
opt.linebreak = true

opt.sessionoptions = 'buffers,curdir,folds,help,tabpages,winsize,globals'
opt.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
vim.wo.wrap = true

opt.mouse = 'a' -- Enable mouse mode

opt.showmode = false -- Don't show the mode, since it's already in the status line

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

opt.breakindent = true -- Enable break indent

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

opt.signcolumn = 'yes' -- Keep signcolumn on by default

opt.updatetime = 250 -- Decrease update time

opt.timeoutlen = 300 -- Decrease mapped sequence wait time

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

opt.inccommand = 'split' -- Preview substitutions live, as you type

opt.cursorline = true -- Show which line your cursor is on

opt.scrolloff = 22 -- Minimal number of screen lines to keep above and below the cursor.

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
opt.confirm = true

opt.backup = false -- Don't create backup files
opt.writebackup = false -- Don't create backup before writing
opt.swapfile = false -- Don't create swap files

-- Global state
vim.g.prettier_disabled = false
vim.g.cokeline_is_picking = false

vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
  virtual_lines = { current_line = true },
  virtual_text = { current_line = false },
}
-- vim: ts=2 sts=2 sw=2 et
