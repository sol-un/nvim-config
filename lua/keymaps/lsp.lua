-- Delete default LSP keymaps to be replaced with Snacks.picker
for _, lhs in ipairs { 'gra', 'grt', 'grn', 'grr', 'gri', 'gO' } do
  pcall(vim.keymap.del, { 'n', 'x' }, lhs)
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local is_inlay_hint_suported = client and client:supports_method('textDocument/inlayHint', event.buf)
    local is_codelens_supported = client and client:supports_method('textDocument/codeLens', event.buf)

    require('which-key').add {
      {
        ']]',
        function()
          require('snacks').words.jump(1, true)
        end,
        desc = 'Next occurrence',
      },
      {
        '[[',
        function()
          require('snacks').words.jump(-1, true)
        end,
        desc = 'Prev occurrence',
      },
      {
        'gd',
        function()
          require('snacks').picker.lsp_definitions()
        end,
        desc = 'LSP: Goto definition',
      },
      {
        'gr',
        function()
          require('snacks').picker.lsp_references()
        end,
        desc = 'LSP: References',
      },
      {
        'gI',
        function()
          require('snacks').picker.lsp_implementations()
        end,
        desc = 'LSP: Goto implementation',
      },
      {
        'gy',
        function()
          require('snacks').picker.lsp_type_definitions()
        end,
        desc = 'LSP: Goto type definition',
      },
      { 'gD', vim.lsp.buf.declaration, desc = 'LSP: Goto declaration' },

      { 'gl', group = 'Language tools' },

      { 'gla', vim.lsp.buf.code_action, desc = 'Code actions', mode = { 'n', 'x' } },
      { 'gld', vim.diagnostic.open_float, desc = 'Show diagnostics' },
      {
        'gls',
        function()
          require('snacks').picker.lsp_symbols()
        end,
        desc = 'Search document symbols',
      },
      {
        'glS',
        function()
          require('snacks').picker.lsp_workspace_symbols()
        end,
        desc = 'Search workspace symbols',
      },
      { 'glr', vim.lsp.buf.rename, desc = 'Rename' },
      {
        'gll',
        function()
          vim.lsp.codelens.refresh { bufnr = 0 }
        end,
        desc = 'Refresh & display codelens',
        cond = is_codelens_supported,
      },
    }

    if is_inlay_hint_suported then
      require('snacks').toggle.inlay_hints():map '<Leader>Th'
    end
  end,
})
