local markdownlint = require('null-ls').builtins.diagnostics.markdownlint.with {
  extra_args = { '--disable', 'MD013', 'MD033' },
}

local keymaps_meta = {
  { desc = 'Bold', key = 'b', symbol = '**' },
  { desc = 'Italic', key = 'i', symbol = '_' },
  { desc = 'Code', key = 'c', symbol = '`' },
  { desc = 'Strikethrough', key = 's', symbol = '~~' },
}

local add_md_link = function(rhs)
  local link = vim.fn.input 'URL'
  if link == nil or link == '' then
    return
  end

  local rhs_with_link = string.format(rhs, link)
  local input = vim.api.nvim_replace_termcodes(rhs_with_link, true, false, true)
  vim.api.nvim_feedkeys(input, 'n', false)
end

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
    init = function()
      require('which-key').add { '<Leader>m', group = 'Markdown', icon = { icon = ' ', color = 'grey' } }
      local set = require('snacks').keymap.set

      set('n', '<Leader>mt', '<cmd>RenderMarkdown buf_toggle<cr>', { ft = 'markdown', desc = 'Toggle preview' })

      vim.iter(keymaps_meta):each(function(keymap_meta)
        local key = keymap_meta.key
        local sym = keymap_meta.symbol
        local desc = keymap_meta.desc

        set('v', '<Leader>m' .. key, string.format('c%s<c-r>"%s<esc>', sym, sym), { ft = 'markdown', desc = desc })
        set('n', '<Leader>m' .. key, string.format('viwc%s<c-r>"%s<esc>', sym, sym), { ft = 'markdown', desc = desc })
      end)

      set('v', '<Leader>ml', function()
        add_md_link 'c[<c-r>"](%s)<esc>'
      end, { ft = 'markdown', desc = 'Link' })

      set('n', '<Leader>ml', function()
        add_md_link 'viwc[<c-r>"](%s)<esc>'
      end, { ft = 'markdown', desc = 'Link' })

      set('n', '<Leader>mC', function()
        local language = vim.fn.input 'Language'
        if language == nil or language == '' then
          return
        end

        local block_top = '```' .. language
        vim.api.nvim_put({ block_top, '```' }, 'c', true, true)
      end, { ft = 'markdown', desc = 'Insert code block' })
    end,
  },
}
