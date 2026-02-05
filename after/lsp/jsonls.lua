return {
  before_init = function(_, config)
    (config.settings or {}).json.schemas = require('schemastore').json.schemas()
    vim.list_extend(config.filetypes or {}, { 'json5' })
  end,
  settings = {
    json = {
      validate = { enable = true },
    },
  },
}
