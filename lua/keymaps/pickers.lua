require('which-key').add {
  { '<Leader>f', group = 'Find' },
  {
    '<Leader>,',
    function()
      require('snacks').picker.buffers()
    end,
    desc = 'Find buffers',
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
      require('snacks').picker.grep_word()
    end,
    desc = 'Find word under cursor',
  },
  {
    '<Leader>fC',
    function()
      require('snacks').picker.commands()
    end,
    desc = 'Find commands',
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
      require('snacks').picker.recent()
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
    '<Leader>fr',
    function()
      require('snacks').picker.registers()
    end,
    desc = 'Find registers',
  },
  {
    '<Leader>fp',
    function()
      require('snacks').picker.projects()
    end,
    desc = 'Find projects',
  },
  {
    '<Leader>fs',
    function()
      require('snacks').picker.smart()
    end,
    desc = 'Find buffers/recent/files',
  },
  {
    '<Leader>fS',
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
    '<Leader>fF',
    function()
      require('snacks').picker.files { hidden = true, ignored = true }
    end,
    desc = 'Find all files',
  },
  {
    '<Leader>fO',
    function()
      require('snacks').picker.recent { filter = { cwd = true } }
    end,
    desc = 'Find old files (cwd)',
  },
  {
    '<Leader>ff',
    function()
      require('snacks').picker.files { hidden = vim.tbl_get((vim.uv or vim.loop).fs_stat '.git' or {}, 'type') == 'directory' }
    end,
    desc = 'Find files',
  },
  {
    '<Leader>fw',
    function()
      require('snacks').picker.grep()
    end,
    desc = 'Find words',
    cond = vim.fn.executable 'rg' == 1,
  },
  {
    '<Leader>fW',
    function()
      require('snacks').picker.grep { hidden = true, ignored = true }
    end,
    desc = 'Find words in all files',
    cond = vim.fn.executable 'rg' == 1,
  },
}
