local opt = vim.opt

opt.number = true -- Line numbers
opt.relativenumber = true -- Relative line numbers
opt.cursorline = true -- Highlight current line
opt.scrolloff = 99 -- Keep cursor in the middle of the screen
opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
opt.spelllang = { 'en', 'ru' }

-- Indentation
opt.tabstop = 2 -- Tab width
opt.shiftwidth = 2 -- Indent width
opt.softtabstop = 2 -- Soft tab stop
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Smart auto-indenting
opt.autoindent = true -- Copy indent from current line
opt.shiftround = true -- Round indent
opt.breakindent = true -- Enable break indent

-- Search settings
opt.ignorecase = true -- Case insensitive search
opt.smartcase = true -- Case sensitive if uppercase in search
opt.hlsearch = false -- Don't highlight search results
opt.incsearch = true -- Show matches as you type

-- Visual settings
opt.termguicolors = true -- Enable 24-bit colors
opt.signcolumn = 'yes' -- Always show sign column
opt.showmatch = true -- Highlight matching brackets
opt.matchtime = 2 -- How long to show matching bracket
opt.cmdheight = 1 -- Command line height
opt.showmode = false -- Don't show mode in command line
opt.pumheight = 10 -- Popup menu height
opt.pumblend = 10 -- Popup menu transparency
opt.winblend = 0 -- Floating window transparency
opt.completeopt = 'menu,menuone,noselect'
opt.conceallevel = 0 -- Disable syntax concealment
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.synmaxcol = 300 -- Syntax highlighting limit
opt.ruler = false -- Disable the default ruler
opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
opt.winminwidth = 5 -- Minimum window width
opt.winborder = 'rounded'

-- File handling
opt.backup = false -- Don't create backup files
opt.writebackup = false -- Don't create backup before writing
opt.swapfile = false -- Don't create swap files
opt.undofile = true -- Persistent undo
opt.undolevels = 10000

local undodir = vim.fn.expand '~/.vim/undodir' -- Create undo directory if it doesn't exist
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, 'p')
end
opt.undodir = undodir -- Undo directory

opt.updatetime = 300 -- Faster completion
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
opt.ttimeoutlen = 0 -- Key code timeout
opt.autoread = true -- Auto reload files changed outside vim
opt.autowrite = true -- Auto save

-- Behavior settings
opt.hidden = true -- Allow hidden buffers
opt.errorbells = false -- No error bells
opt.backspace = 'indent,eol,start' -- Better backspace behavior
opt.autochdir = false -- Don't auto change directory
opt.iskeyword:append '-' -- Treat dash as part of word
opt.path:append '**' -- include subdirectories in search
opt.mouse = 'a' -- Enable mouse support
opt.modifiable = true -- Allow buffer modifications
opt.encoding = 'UTF-8' -- Set encoding
opt.sessionoptions = 'buffers,curdir,folds,globals,tabpages,winpos,winsize,help'
opt.autocomplete = false -- Handled by blink.cmp
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

-- Folding settings
opt.smoothscroll = true
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevel = 99 -- Start with all folds open
opt.foldlevelstart = 99

-- Split behavior
opt.splitbelow = true -- Horizontal splits go below
opt.splitright = true -- Vertical splits go right
opt.splitkeep = 'screen'

-- Command-line completion
opt.wildmenu = true
opt.wildmode = 'longest:full,full'
opt.wildignore:append { '*.o', '*.obj', '*.pyc', '*.class', '*.jar' }

-- Better diff options
opt.diffopt:append 'linematch:60'

-- Performance improvements
opt.redrawtime = 10000
opt.maxmempattern = 20000

opt.fillchars = {
  diff = '╱',
}

-- OS-specific
if require('utils').is_windows() then
  opt.shell = 'powershell'

  vim.defer_fn(function()
    -- Fix netcoredbg breakpoints. See https://github.com/mfussenegger/nvim-dap/discussions/1156
    opt.shellslash = false
  end, 500)
end

if require('utils').is_wsl() then
  vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = true,
  }
end

opt.jumpoptions = 'view'
opt.laststatus = 3 -- global statusline
opt.wrap = true
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true -- Show some invisible characters (tabs...
opt.shortmess:append { W = true, I = true, c = true, C = true }

vim.g.markdown_recommended_style = 0

vim.filetype.add {
  extension = {
    env = 'dotenv',
  },
  filename = {
    ['.env'] = 'dotenv',
    ['env'] = 'dotenv',
  },
  pattern = {
    ['[jt]sconfig.*.json'] = 'jsonc',
    ['%.env%.[%w_.-]+'] = 'dotenv',
  },
}

vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = true,
  signs = {
    text = {
      -- There is already virtual text for diagnostics, so conceal for less visual noise
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
  virtual_lines = { current_line = true },
  virtual_text = { current_line = false },
}
