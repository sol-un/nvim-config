return {
  {
    'Bekaboo/dropbar.nvim',
    opts = {
      bar = {
        sources = function()
          local sources = require 'dropbar.sources'
          local utils = require 'dropbar.utils'

          return {
            sources.treesitter,
            utils.source.fallback {
              sources.lsp,
            },
          }
        end,
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      -- Overriding to conceal the dropbar at the top
      winbar = { lualine_a = { '' } },
    },
  },
}
