local status, colorizer = pcall(require, 'colorizer')
if not status then
  vim.notify('没有找到 nvim-colorizer')
  return
end

colorizer.setup()

