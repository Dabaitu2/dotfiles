local status, calcSum = pcall(require, 'local-plugins.calc-sum')

if not status then
  vim.notify('加载 calc-sum 失败')
  return
end

vim.api.nvim_create_augroup('calcSum', {})
vim.api.nvim_create_autocmd('TextChangedI', {
  group = 'calcSum',
  pattern = '*',
  callback = calcSum.show_virtual_text,
})
vim.api.nvim_create_autocmd('InsertLeave', {
  group = 'calcSum',
  pattern = '*',
  callback = calcSum.show_virtual_text,
})

_G.replace_expression_with_result = calcSum.replace_expression_with_result
_G.show_virtual_text_sum = calcSum.show_virtual_text

if status then
  vim.keymap.set('i', '<Tab>', function()
    if not require('local-plugins.calc-sum').replace_expression_with_result() then
      return '<Tab>'
    end
  end, { noremap = true })
end
