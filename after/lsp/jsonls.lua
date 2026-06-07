local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

--- @type vim.lsp.Config
return {
  capabilities = capabilities,
  before_init = function(_, config)
    vim.list_extend(config.filetypes or {}, { 'json5' })
  end,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}
