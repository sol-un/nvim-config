return {
  before_init = function(_, config)
    vim.list_extend(config.settings.cssVariables.lookupFiles, { 'node_modules/@skbkontur/colors/colors.css' })
  end,
}
