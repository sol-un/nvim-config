return {
  before_init = function(_, config)
    vim.list_extend(config.settings.cssVariables.lookupFiles, {
      'node_modules/@skbkontur/colors/colors.css',
      'node_modules/@skbkontur/colors/tokens/brand-blue-deep_accent-brand.css',
    })
  end,
}
