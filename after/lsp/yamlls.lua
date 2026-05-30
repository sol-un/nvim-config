---@type vim.lsp.Config
return {
  settings = {
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
    yaml = {
      schemas = require('schemastore').yaml.schemas(),
      schemaStore = {
        enable = false,
        url = '',
      },
      validate = true,
    },
  },
}
