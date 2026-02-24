-- diagnostics.lua
---@diagnostic disable: undefined-global
local signs = {
  Error = '',
  Warn = '',
  Hint = '',
  Info = '',
}
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  -- virtual_text = false, -- 禁用默认行尾虚拟文本
  -- float = { border = 'rounded', source = 'always' }, -- 启用悬浮窗口并显示来源
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- 移除自动触发的光标悬停诊断

-- 设置 CursorHold 触发时间（毫秒）
vim.o.updatetime = 300
