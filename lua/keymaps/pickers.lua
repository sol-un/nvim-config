require('which-key').add {
  { '<Leader>f', group = 'Find' },
  {
    '<Leader>,',
    function()
      require('snacks').picker.buffers()
    end,
    desc = 'Open buffers',
  },
  {
    '<Leader>f<CR>',
    function()
      require('snacks').picker.resume()
    end,
    desc = 'Resume previous search',
  },
  {
    '<Leader>fl',
    function()
      require('snacks').picker.lines()
    end,
    desc = 'Find lines',
  },
  {
    '<Leader>fc',
    function()
      require('snacks').picker.grep_word { hidden = true, ignored = true }
    end,
    desc = 'Find word under cursor',
  },
  {
    '<Leader>fh',
    function()
      require('snacks').picker.help()
    end,
    desc = 'Find help',
  },
  {
    '<Leader>fk',
    function()
      require('snacks').picker.keymaps()
    end,
    desc = 'Find keymaps',
  },
  {
    '<Leader>fn',
    function()
      require('snacks').picker.notifications()
    end,
    desc = 'Find notifications',
  },
  {
    '<Leader>fo',
    function()
      require('snacks').picker.recent { hidden = true, ignored = true }
    end,
    desc = 'Find old files',
  },
  {
    '<Leader>fm',
    function()
      require('snacks').picker.marks()
    end,
    desc = 'Find marks',
  },
  {
    '<Leader>fs',
    function()
      require('snacks').picker.smart { hidden = true, ignored = true }
    end,
    desc = 'Find buffers/recent/files',
  },
  {
    '<Leader>fp',
    function()
      require('snacks').picker.snippets()
    end,
    desc = 'Find snippets',
  },
  {
    '<Leader>fu',
    function()
      require('snacks').picker.undo()
    end,
    desc = 'Find undo history',
  },
  {
    '<Leader>fj',
    function()
      require('snacks').picker.undo()
    end,
    desc = 'Find jumps',
  },
  {
    '<Leader>ff',
    function()
      require('snacks').picker.files { hidden = true, ignored = true }
    end,
    desc = 'Find files',
  },
  {
    '<Leader>fw',
    function()
      require('snacks').picker.grep { hidden = true, ignored = true }
    end,
    desc = 'Find words',
    cond = vim.fn.executable 'rg' == 1,
  },
}
