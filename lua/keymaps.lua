local wk = require 'which-key'
local bufdelete = require('snacks').bufdelete
local picker = require('snacks').picker
local cokeline = require 'cokeline.mappings'

wk.add {
  { '<Esc>', '<cmd>nohlsearch<CR>' }, -- Clear highlights on search when pressing <Esc> in normal mode
  { '<leader>x', vim.diagnostic.setloclist, desc = 'Open diagnostic quickfix list' },
  { '<Esc><Esc>', '<C-\\><C-n>', desc = 'Exit terminal mode', mode = 't' }, -- This won't work in all terminal emulators/tmux/etc
  { '<C-s>', '<Cmd>w<CR><Esc>', mode = { 'n', 'i', 'v', 's' } }, -- Save
  { '<Leader>q', group = 'Quit' },
  { '<Leader>qq', '<Cmd>confirm qall<CR>', desc = 'Quit' },

  { '<Leader>p', group = 'Packages', icon = '' },
  { '<Leader>pi', '<cmd>Lazy home<cr>', desc = 'Plugins' },
  { '<Leader>pm', '<cmd>Mason<cr>', desc = 'Mason' },

  { '<Leader><Tab>', group = 'Tabs' },
  { '<Leader><Tab>o', '<cmd>tabonly<cr>', desc = 'Close Other Tabs' },
  { '<Leader><Tab><Tab>', '<cmd>tabnew<cr>', desc = 'New Tab' },
  { '<Leader><Tab>d', '<cmd>tabclose<cr>', desc = 'Close Tab' },
  { 'gt', '<cmd>tabnext<cr>', desc = 'Next Tab' },
  { 'gT', '<cmd>tabprevious<cr>', desc = 'Previous Tab' },

  { '<Leader>w', group = 'Windows' },
  { '<C-h>', '<C-w><C-h>', desc = 'Move focus to the left window' },
  { '<C-l>', '<C-w><C-l>', desc = 'Move focus to the right window' },
  { '<C-j>', '<C-w><C-j>', desc = 'Move focus to the lower window' },
  { '<C-k>', '<C-w><C-k>', desc = 'Move focus to the upper window' },
  { '<Leader>wv', '<cmd>vsplit<cr>', desc = 'Vertical split' },
  { '<Leader>wd', '<C-W>c', desc = 'Close current window' },
  { '<Leader>wh', '<cmd>split<cr>', desc = 'Horizontal split' },
  { '<Leader>wo', '<cmd>only<cr>', desc = 'Close all other windows' },
  { '<Leader>wJ', '<C-W>J', desc = 'Move window to far bottom' },
  { '<Leader>wK', '<C-W>K', desc = 'Move window to far top' },
  { '<Leader>wH', '<C-W>H', desc = 'Move window to far left' },
  { '<Leader>wL', '<C-W>L', desc = 'Move window to far right' },

  { '<Leader>b', group = 'Buffers' },
  { 'L', '<Plug>(cokeline-focus-next)', desc = 'Next buffer' },
  { 'H', '<Plug>(cokeline-focus-prev)', desc = 'Previous buffer' },
  { '<Leader>bd', bufdelete.delete, desc = 'Close current buffer' },
  { '<Leader>bo', bufdelete.other, desc = 'Close all other buffers' },
  { '<Leader>bA', bufdelete.all, desc = 'Close all buffers' },
  { '<Leader>bb', '<Plug>(cokeline-pick-focus)', desc = 'Focus buffer from tabline' },
  { '<Leader>bD', '<Plug>(cokeline-pick-close)', desc = 'Close buffer from tabline' },
  {
    '<Leader>bp',
    function()
      local last = require('cokeline.history'):last()
      if last ~= nil then
        cokeline.by_index('focus', last.index)
      else
        vim.notify('Buffer history is empty', 'info')
      end
    end,
    desc = 'Focus last buffer',
  },
  {
    '<Leader>bh',
    function()
      vim.g.cokeline_is_picking = true
      cokeline.pick(function(buf)
        vim.cmd.split()
        cokeline.by_index('focus', buf.index)
        vim.g.cokeline_is_picking = false
      end)
    end,
    desc = 'Horizontal split buffer from tabline',
  },
  {
    '<Leader>bv',
    function()
      vim.g.cokeline_is_picking = true
      cokeline.pick(function(buf)
        vim.cmd.vsplit()
        cokeline.by_index('focus', buf.index)
        vim.g.cokeline_is_picking = false
      end)
    end,
    desc = 'Vertical split buffer from tabline',
  },

  { '<Leader>f', group = 'Find' },
  { '<Leader>,', picker.buffers, desc = 'Find buffers' },
  { '<Leader>f<CR>', picker.resume, desc = 'Resume previous search' },
  { '<Leader>fl', picker.lines, desc = 'Find lines' },
  { '<Leader>fc', picker.grep_word, desc = 'Find word under cursor' },
  { '<Leader>fC', picker.commands, desc = 'Find commands' },
  { '<Leader>fh', picker.help, desc = 'Find help' },
  { '<Leader>fk', picker.keymaps, desc = 'Find keymaps' },
  { '<Leader>fn', picker.notifications, desc = 'Find notifications' },
  { '<Leader>fo', picker.recent, desc = 'Find old files' },
  { '<Leader>fm', picker.man, desc = 'Find man' },
  { '<Leader>fr', picker.registers, desc = 'Find registers' },
  { '<Leader>fp', picker.projects, desc = 'Find projects' },
  { '<Leader>fs', picker.smart, desc = 'Find buffers/recent/files' },
  { '<Leader>fu', picker.undo, desc = 'Find undo history' },
  {
    '<Leader>fF',
    function()
      picker.files { hidden = true, ignored = true }
    end,
    desc = 'Find all files',
  },
  {
    '<Leader>fO',
    function()
      picker.recent { filter = { cwd = true } }
    end,
    desc = 'Find old files (cwd)',
  },
  {
    '<Leader>ff',
    function()
      require('snacks').picker.files { hidden = vim.tbl_get((vim.uv or vim.loop).fs_stat '.git' or {}, 'type') == 'directory' }
    end,
    desc = 'Find files',
  },
  { '<Leader>fw', picker.grep, desc = 'Find words', cond = vim.fn.executable 'rg' == 1 },
  {
    '<Leader>fW',
    function()
      picker.grep { hidden = true, ignored = true }
    end,
    desc = 'Find words in all files',
    cond = vim.fn.executable 'rg' == 1,
  },

  -- Keymaps defined per plugin in plugins/git
  { '<Leader>g', group = 'Git' },
  { '<Leader>gl', group = 'GitLab', icon = { icon = '', color = 'orange' } },

  { '<Leader>S', group = 'Session' },
}

-- Delete default LSP keymaps to be replaced with Snacks.picker
for _, lhs in ipairs { 'gra', 'grt', 'grn', 'grr', 'gri', 'gO' } do
  pcall(vim.keymap.del, { 'n', 'x' }, lhs)
end

-- These keymaps are available only with an LSP attached
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local is_inlay_hint_suported = client and client:supports_method(client, 'textDocument_inlayHint', event.buf)

    wk.add {
      { 'gl', group = 'Language tools' },
      { 'gd', picker.lsp_definitions, desc = 'LSP: Goto definition' },
      { 'gr', picker.lsp_references, desc = 'LSP: References' },
      { 'gI', picker.lsp_references, desc = 'LSP: Goto implementation' },
      { 'gy', picker.lsp_references, desc = 'LSP: Goto type definition' },
      { 'gD', vim.lsp.buf.declaration, desc = 'LSP: Goto declaration' },
      { 'gla', vim.lsp.buf.code_action, desc = 'Code actions', mode = { 'n', 'x' } },
      { 'gld', vim.diagnostic.open_float, desc = 'Show diagnostics' },
      { 'gls', picker.lsp_symbols, desc = 'Search document symbols' },
      { 'glS', picker.lsp_workspace_symbols, desc = 'Search workspace symbols' },
      { 'glr', vim.lsp.buf.rename, desc = 'Rename' },
      {
        '<leader>th',
        function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end,
        desc = 'Toggle inlay hints',
        cond = is_inlay_hint_suported,
      },
    }
  end,
})

-- vim: ts=2 sts=2 sw=2 et
