local status, hlargs = pcall(require, 'hlargs')
if not status then
  vim.notify('没有找到 hlargs')
  return
end

hlargs.setup()
