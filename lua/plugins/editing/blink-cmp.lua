return {
  {
    'saghen/blink.cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = 'make install_jsregexp',
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'moyiz/blink-emoji.nvim',
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      cmdline = {
        enabled = true,
        keymap = {
          preset = 'cmdline',
        },
        completion = {
          list = { selection = { preselect = false } },
          menu = {
            auto_show = function()
              return vim.fn.getcmdtype() == ':'
            end,
          },
          ghost_text = { enabled = true },
        },
      },
      keymap = {
        preset = 'default',
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        documentation = { auto_show = true, window = { border = 'rounded' } },
        menu = { border = 'rounded' },
      },
      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'lazydev',
          'buffer',
          'easy-dotnet',
          'emoji',
        },
        providers = {
          snippets = { score_offset = 100 },
          lsp = {
            score_offset = 100,
            fallbacks = {},
          },
          buffer = {
            opts = {
              -- filter to only "normal" buffers
              get_bufnrs = function()
                return vim.tbl_filter(function(bufnr)
                  return vim.bo[bufnr].buftype == ''
                end, vim.api.nvim_list_bufs())
              end,
            },
          },
          lazydev = {
            module = 'lazydev.integrations.blink',
          },
          ['easy-dotnet'] = {
            name = 'easy-dotnet',
            enabled = true,
            module = 'easy-dotnet.completion.blink',
            async = true,
          },
          emoji = {
            name = 'emoji',
            module = 'blink-emoji',
          },
        },
      },
      snippets = { preset = 'luasnip' },
      fuzzy = {
        implementation = 'prefer_rust_with_warning',
      },
    },
  },
}
