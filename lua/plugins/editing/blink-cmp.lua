return {
  {
    'saghen/blink.cmp',
    build = function()
      require('blink.cmp').build():wait(60000)
    end,
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
      { 'moyiz/blink-emoji.nvim', cond = false },
      'folke/lazydev.nvim',
      'saghen/blink.lib',
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
          -- 'emoji',
        },
        providers = {
          lsp = {
            score_offset = 100,
            fallbacks = {},
          },
          snippets = {
            score_offset = 100,
          },
          buffer = {
            opts = {
              -- filter to only "normal" and help buffers
              get_bufnrs = function()
                return vim.tbl_filter(function(bufnr)
                  local buftype = vim.bo[bufnr].buftype
                  return buftype == '' or buftype == 'help'
                end, vim.api.nvim_list_bufs())
              end,
            },
          },
          lazydev = {
            module = 'lazydev.integrations.blink',
          },
          -- emoji = {
          --   name = 'emoji',
          --   module = 'blink-emoji',
          --   score_offset = function(ctx)
          --     return ctx.trigger.initial_character == ':' and 100 or 0
          --   end,
          -- },
        },
      },
      snippets = { preset = 'luasnip' },
      fuzzy = {
        sorts = { 'exact', 'score', 'sort_text' },
        implementation = 'prefer_rust_with_warning',
      },
    },
  },
}
