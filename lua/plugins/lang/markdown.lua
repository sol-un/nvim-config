local markdownlint = require('null-ls').builtins.diagnostics.markdownlint.with {
  extra_args = { '--disable', 'MD013', 'MD033' },
}

local keymaps_meta = {
  { desc = 'Bold', key = 'b', symbol = '**' },
  { desc = 'Italic', key = 'i', symbol = '_' },
  { desc = 'Code', key = 'c', symbol = '`' },
  { desc = 'Strikethrough', key = 's', symbol = '~~' },
}

return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'marksman',
        'markdownlint',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = { 'marksman' },
    },
  },
  {
    'nvimtools/none-ls.nvim',
    opts = {
      sources = { markdownlint },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'gitlab' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      preset = 'obsidian',
      anti_conceal = { enabled = false },
      file_types = { 'markdown', 'gitlab' },
    },
    keys = function()
      local set = require('snacks').keymap.set

      set({ 'n', 'v' }, '<Leader>m', '', { desc = '󰽛 Markdown', ft = 'markdown' })
      set('n', '<Leader>mt', '<cmd>RenderMarkdown buf_toggle<cr>', { ft = 'markdown', desc = 'Toggle preview' })
      vim.iter(keymaps_meta):each(function(keymap_meta)
        local key = keymap_meta.key
        local sym = keymap_meta.symbol
        local desc = keymap_meta.desc

        set('v', '<Leader>m' .. key, string.format('c%s<c-r>"%s<esc>', sym, sym), { ft = 'markdown', desc = desc })
        set('n', '<Leader>m' .. key, string.format('viwc%s<c-r>"%s<esc>', sym, sym), { ft = 'markdown', desc = desc })
      end)
    end,
  },
  {
    'antonk52/markdowny.nvim',
    ft = 'markdown',
    keys = function()
      require('snacks').keymap.set('v', '<Leader>ml', ":lua require('markdowny').link()<cr>", { ft = 'markdown', desc = 'Link' })
    end,
  },
}
