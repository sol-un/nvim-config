return {
  'linrongbin16/gitlinker.nvim',
  event = 'VeryLazy',
  opts = {
    router = {
      current_branch = {
        ['^git%.skbkontur%.ru'] = 'https://git.skbkontur.ru/'
            .. '{_A.ORG}/'
            .. '{_A.REPO}/blob/'
            .. '{_A.CURRENT_BRANCH}/'
            .. '{_A.FILE}'
            .. '#L{_A.LSTART}'
            .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
      },
    },
  },
  keys = function()
    local set = vim.keymap.set

    set({ 'n', 'v' }, '<Leader>gy', '<cmd>GitLink current_branch<cr>', { desc = 'Yank git link' })
    set({ 'n', 'v' }, '<Leader>gY', '<cmd>GitLink! current_branch<cr>', { desc = 'Open git link' })
  end,
}
