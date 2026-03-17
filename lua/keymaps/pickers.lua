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
    '<Leader>f/',
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
    desc = 'Lines',
  },
  {
    '<Leader>fw',
    function()
      require('snacks').picker.grep_word { hidden = true, ignored = true }
    end,
    cond = vim.fn.executable 'rg' == 1,
    desc = 'Word (under cursor/selection)',
    mode = { 'n', 'x' },
  },
  {
    '<Leader>fW',
    function()
      require('snacks').picker.grep { hidden = true, ignored = true }
    end,
    desc = 'Word (any)',
    cond = vim.fn.executable 'rg' == 1,
  },
  {
    '<Leader>fh',
    function()
      require('snacks').picker.help()
    end,
    desc = 'Help',
  },
  {
    '<Leader>fk',
    function()
      require('snacks').picker.keymaps()
    end,
    desc = 'Keymaps',
  },
  {
    '<Leader>fn',
    function()
      require('snacks').picker.notifications()
    end,
    desc = 'Notifications',
  },
  {
    '<Leader>fm',
    function()
      require('snacks').picker.marks()
    end,
    desc = 'Marks',
  },
  {
    '<Leader>fs',
    function()
      require('snacks').picker.smart { hidden = true, ignored = true }
    end,
    desc = 'Files (smart)',
  },
  {
    '<Leader>ff',
    function()
      require('snacks').picker.files { hidden = true, ignored = true }
    end,
    desc = 'Files (all)',
  },
  {
    '<Leader>fr',
    function()
      require('snacks').picker.recent {
        filter = {
          paths = {
            [vim.fn.getcwd()] = true,
          },
        },
      }
    end,
    desc = 'Files (recent)',
  },
  {
    '<Leader>fp',
    function()
      require('snacks').picker.snippets()
    end,
    desc = 'Snippets',
  },
  {
    '<Leader>fu',
    function()
      require('snacks').picker.undo()
    end,
    desc = 'Undo history',
  },
  {
    '<Leader>fj',
    function()
      require('snacks').picker.jumps()
    end,
    desc = 'Jumps',
  },
}
