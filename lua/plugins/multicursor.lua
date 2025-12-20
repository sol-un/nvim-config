return {
  'jake-stewart/multicursor.nvim',
  event = 'VeryLazy',
  config = function()
    local mc = require 'multicursor-nvim'
    mc.setup()

    local set = vim.keymap.set

    -- Add or skip cursor above/below the main cursor.
    set({ 'n', 'x' }, '<s-m-k>', function()
      mc.lineAddCursor(-1)
    end)
    set({ 'n', 'x' }, '<s-m-j>', function()
      mc.lineAddCursor(1)
    end)

    -- Add a new cursor by matching word/selection
    set({ 'n', 'x' }, '<s-m-n>', function()
      mc.matchAddCursor(1)
    end)
    set({ 'n', 'x' }, '<s-m-p>', function()
      mc.matchAddCursor(-1)
    end)

    -- Add and remove cursors with alt + left click.
    set('n', '<m-leftmouse>', mc.handleMouse)
    set('n', '<m-leftdrag>', mc.handleMouseDrag)
    set('n', '<m-leftrelease>', mc.handleMouseRelease)

    -- Disable and enable cursors.
    set({ 'n', 'x' }, '<s-m-f>', mc.toggleCursor)

    -- Operator pending mode for multiple cursors
    set('n', '<s-m-g>', mc.addCursorOperator)

    -- Add a cursor for all matches of cursor word/selection in the document.
    set({ 'n', 'x' }, '<s-m-l>', mc.matchAllAddCursors)

    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
    mc.addKeymapLayer(function(layerSet)
      -- Select a different cursor as the main one.
      layerSet({ 'n', 'x' }, '<s-m-h>', mc.prevCursor)
      layerSet({ 'n', 'x' }, '<s-m-l>', mc.nextCursor)

      -- Enable and clear cursors using escape.
      layerSet('n', '<esc>', function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, 'MultiCursorCursor', { reverse = true })
    hl(0, 'MultiCursorVisual', { link = 'Visual' })
    hl(0, 'MultiCursorSign', { link = 'SignColumn' })
    hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
    hl(0, 'MultiCursorDisabledCursor', { reverse = true })
    hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
    hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
  end,
}
