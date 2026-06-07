return {
  {
    'SmiteshP/nvim-navic',
    --- @module 'nvim-navic'
    --- @type Options
    --- @diagnostic disable: missing-fields
    opts = {
      icons = {
        File = '󰈔 ',
        Module = '󰏗 ',
        Namespace = '󰅩 ',
        Package = '󰆦 ',
        Class = ' ',
        Property = ' ',
        Field = ' ',
        Constructor = ' ',
        Enum = ' ',
        Interface = ' ',
        Variable = '󰀫 ',
        String = '󰉾 ',
        Boolean = ' ',
        Null = '󰢤 ',
        EnumMember = ' ',
        Struct = ' ',
        TypeParameter = '󰆩 ',
      },
      highlight = true,
      separator = '  ',
      lsp = {
        auto_attach = true,
      },
    },
  },
}
