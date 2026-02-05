return {
  before_init = function(_, config)
    (config.settings or {}).yaml.schemas = require('schemastore').yaml.schemas()
  end,
  settings = {
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
    yaml = {
      schemaStore = {
        enable = false,
        url = '',
      },
      validate = true,
    },
  },
}
