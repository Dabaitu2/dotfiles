-- lspsaga 配置（最简单，默认即可）
local status_ok, lspsaga = pcall(require, 'lspsaga')
if not status_ok then
  return
end

lspsaga.setup({
  -- 诊断相关配置
  diagnostic = {
    -- 正常高度显示的诊断数量
    show_normal_height = 20,
    -- 扩展显示相关信息
    extend_relatedInformation = true,
    -- 诊断窗口最大高度比例
    max_height = 0.8,
    -- 诊断窗口最大显示高度比例
    max_show_height = 0.8,
  },
})
