vim.opt.backup = false
vim.opt.writebackup = false

-- Highlight the symbol and its references when holding the cursor.
vim.api.nvim_create_augroup('CocGroup', {})
vim.api.nvim_create_autocmd('CursorHold', {
  group = 'CocGroup',
  command = "silent call CocActionAsync('highlight')",
  desc = 'Highlight symbol under cursor on CursorHold',
})

require('keybindings').mapCoc()
