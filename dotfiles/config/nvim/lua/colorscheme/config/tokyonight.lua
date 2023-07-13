require('tokyonight').setup({
  style = 'night',
  -- transparent = true,
  functions = {
    italic = true,
  },
  styles = {
    -- sidebars = 'transparent',
    -- floats = 'transparent',
    -- comments = { italic = false },
  },
  on_highlights = function(hl, c)
    hl.TelescopeNormal = {
      bg = nil,
    }
    hl.TelescopePromptBorder = {
      bg = nil,
    }
    hl.TelescopePromptTitle = {
      bg = nil,
    }
    hl.TelescopePreviewTitle = {
      bg = nil,
    }
    hl.TelescopeResultsTitle = {
      bg = nil,
    }
  end,
})

vim.cmd([[highlight rustTSInclude guifg=#bb9af7]])
vim.cmd([[highlight CursorLine guibg=#1e202d]])
vim.cmd([[highlight CursorLine guibg=#202020]])
vim.cmd([[highlight CocRustTypeHint guibg=NONE guifg=#787878]])
