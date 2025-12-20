return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      show_help = false,
      preset = 'helix',
      icons = {

        mappings = vim.g.have_nerd_font,
      },

      spec = {
        { '<leader>t', group = 'Toggle' },
        { '<Leader>g', group = 'Git' },
        { '<Leader>q', group = 'Quit' },
        { '<Leader>w', group = 'Windows' },
      },
    },
  },
}
