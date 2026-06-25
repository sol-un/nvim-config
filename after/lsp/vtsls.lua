--- @type vim.lsp.Config
return {
  settings = {
    typescript = {
      tsserver = {
        maxTsServerMemory = 24576,
      },
    },
    vtsls = {
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
  },
}
