local snippets_picker = {
  supports_live = false,
  preview = 'preview',
  format = function(item, picker)
    local name = require('snacks').picker.util.align(item.name, picker.align_1 + 1)
    return {
      { name, item.ft == '' and 'Conceal' or 'DiagnosticWarn' },
      { item.description },
    }
  end,
  finder = function(_, ctx)
    local snippets = {}
    for _, snip in ipairs(require('luasnip').get_snippets().all) do
      snip.ft = ''
      table.insert(snippets, snip)
    end
    for _, snip in ipairs(require('luasnip').get_snippets(vim.bo.ft)) do
      snip.ft = vim.bo.ft
      table.insert(snippets, snip)
    end
    local align_1 = 0
    for _, snip in pairs(snippets) do
      align_1 = math.max(align_1, #snip.trigger)
    end
    ctx.picker.align_1 = align_1
    local items = {}
    for _, snip in pairs(snippets) do
      local docstring = snip:get_docstring()
      if type(docstring) == 'table' then
        docstring = table.concat(docstring)
      end
      local name = snip.name
      local description = table.concat(snip.description)
      description = name == description and name or description
      table.insert(items, {
        text = snip.trigger .. ' ' .. description, -- search string
        name = snip.trigger,
        description = description,
        trigger = snip.trigger,
        ft = snip.ft,
        preview = {
          ft = snip.ft,
          text = docstring,
        },
      })
    end
    return items
  end,
  confirm = function(picker, item)
    picker:close()
    --
    local expand = {}
    require('luasnip').available(function(snippet)
      if snippet.trigger == item.trigger then
        table.insert(expand, snippet)
      end
      return snippet
    end)
    if #expand > 0 then
      vim.cmd ':startinsert!'
      vim.defer_fn(function()
        require('luasnip').snip_expand(expand[1])
      end, 50)
    else
      require('snacks').notify.warn 'No snippet to expand'
    end
  end,
}

return {
  'folke/snacks.nvim',
  priority = 1000,
  opts = function(_, opts)
    --- @module 'snacks'
    --- @type snacks.Config
    --- @diagnostic disable: missing-fields
    local config = {
      notifier = {},
      indent = {},
      scroll = {},
      words = {},
      dashboard = {
        preset = {
          header = '',
        },
        sections = { { section = 'header' } },
      },
      statuscolumn = {
        left = { 'git' }, -- priority of signs on the left (high to low)
        right = { 'sign', 'mark', 'fold' }, -- priority of signs on the right (high to low)
        folds = { open = true },
      },
      bigfile = {},
      picker = {
        actions = require('trouble.sources.snacks').actions,
        win = {
          wo = { wrap = true },
          input = {
            keys = {
              ['<C-q>'] = {
                'trouble_open',
                mode = { 'n', 'i' },
              },
            },
          },
        },
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            layout = {
              fullscreen = false,
              preview = 'main',
            },
          },
          select = { layout = { fullscreen = false } },
          lines = { layout = { fullscreen = false } },
          files = {
            hidden = true,
            ignored = true,
          },
          grep = { hidden = true },
          grep_word = { hidden = true },
          recent = { hidden = true, ignored = true },
          snippets = snippets_picker,
        },
        layout = {
          fullscreen = true,
        },
      },
    }

    return vim.tbl_deep_extend('force', opts or {}, config)
  end,
}
