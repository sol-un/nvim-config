--- @type vim.lsp.Config
return {
  settings = {
    typescript = {
      tsserver = {
        maxTsServerMemory = 24576,
      },
    },
    vtsls = {
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
  },
}
