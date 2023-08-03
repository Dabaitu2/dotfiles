-- pcall 在 lua 中用于捕获错误, .. 用于链接两个字符串
-- local colorscheme = 'tokyonight'
-- local colorscheme = 'carbonfox'
local colorscheme = 'catppuccin'
local colorscheme_config = 'colorscheme.config.' .. colorscheme

-- 尝试加载配置
local config_ok, _ = pcall(require, colorscheme_config)
if not config_ok then
  vim.notify("Can't read colorscheme " .. colorscheme .. "'s config! ")
end

-- 尝试设置 colorscheme
local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
  vim.notify('colorscheme ' .. colorscheme .. ' not found! ')
  return
end
