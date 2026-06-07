return {
  'folke/noice.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  --- @module 'noice'
  --- @type NoiceConfig
  --- @diagnostic disable: missing-fields
  opts = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
    },
    presets = { bottom_search = false, lsp_doc_border = true },
  },
}
