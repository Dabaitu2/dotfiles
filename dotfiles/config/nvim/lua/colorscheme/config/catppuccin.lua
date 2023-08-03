require('catppuccin').setup({
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = false,
    mini = false,
  },
  flavour = 'mocha',
  transparent_background = true, -- disables setting the background color.
  styles = {
    comments = {},
  },
})
