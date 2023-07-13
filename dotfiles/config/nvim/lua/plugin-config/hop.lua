local status, hop = pcall(require, 'hop')
if not status then
  vim.notify('没有找到 hop')
  return
end

hop.setup({
})

vim.api.nvim_set_keymap('n', '<leader>hw', "<cmd> lua require'hop'.hint_words({})<cr>", {})
vim.api.nvim_set_keymap('v', '<leader>hw', "<cmd> lua require'hop'.hint_words({})<cr>", {})
vim.api.nvim_set_keymap('o', '<leader>hw', "<cmd> lua require'hop'.hint_words({})<cr>", {})
