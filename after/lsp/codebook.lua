--- @type vim.lsp.Config
return {
  -- Disable virtual text diagnostics specifically for codebook to reduce visual noise
  on_attach = function(client)
    local ns = vim.lsp.diagnostic.get_namespace(client.id)
    vim.diagnostic.config({ virtual_text = false }, ns)
  end,
}
