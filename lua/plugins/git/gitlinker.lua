return {
  'linrongbin16/gitlinker.nvim',
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
  keys = {
    { '<Leader>gy', '<cmd>GitLink current_branch<cr>', desc = 'Yank git link', mode = { 'n', 'v' } },
    { '<Leader>gY', '<cmd>GitLink! current_branch<cr>', desc = 'Open git link', mode = { 'n', 'v' } },
  },
}
