local stylua = require('null-ls').builtins.formatting.stylua
local selene = require('null-ls').builtins.diagnostics.selene

return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'lua-language-server',
        'stylua',
        'selene',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = { 'lua_ls' },
    },
  },
  {
    'nvimtools/none-ls.nvim',
    opts = {
      sources = { stylua, selene },
    },
  },
  {
    'folke/lazydev.nvim', -- used for completion, annotations and signatures of Neovim apis
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
}
