return {
  'chrisgrieser/nvim-origami',
  event = 'VeryLazy',
  --- @module 'origami'
  --- @type Origami.config
  --- @diagnostic disable: missing-fields
  opts = {
    foldtext = {
      disableOnFt = { 'NeogitStatus', 'NeogitLogView', 'grug-far' },
    },
    autoFold = {
      enabled = false,
    },
  },
}
