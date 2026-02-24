local M = {}
-- namespace 用于限制所有的操作都只是针对这个插件的工作生效
local namespace_id = vim.api.nvim_create_namespace('simple_math_virtual_text')

-- 解析输入模式下当前行的算术表达式
local function parse_arithmetic_expression()
  -- 匹配形如 "x + y" 的表达式
  local line = vim.api.nvim_get_current_line()
  local x, y = string.match(line, '(%d+%.?%d*)%s*%+%s*(%d+%.?%d*)')
  if x and y then
    return tonumber(x), tonumber(y)
  end

  return nil, nil
end

-- 使用虚拟文本显示结果
function M.show_virtual_text()
  local x, y = parse_arithmetic_expression()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line_number = cursor[1]

  vim.api.nvim_buf_clear_namespace(0, namespace_id, 0, -1)
  if x and y then
    -- 计算结果
    local result = x + y

    -- 在当前行后面显示结果（使用虚拟文本）
    vim.api.nvim_buf_set_virtual_text(0, namespace_id, line_number - 1, { { ' = ' .. result, 'Comment' } }, {})
  end
end

-- 替换当前行中的算术表达式为其结果
function M.replace_expression_with_result()
  local x, y = parse_arithmetic_expression()
  local line = vim.api.nvim_get_current_line()
  local cursor = vim.api.nvim_win_get_cursor(0)

  if x and y then
    -- 清除所有虚拟文本提示。
    vim.api.nvim_buf_clear_namespace(0, namespace_id, 0, -1)

    -- 替换当前行中匹配到的第一个算术表达式为计算结果
    local result = x + y
    local pattern_replacement = '(%d+%.?%d*)%s*%+%s*(%d+%.?%d*)'
    line = string.gsub(line, pattern_replacement, tostring(result), 1)

    -- 设置替换后的行内容回去，并移动游标到修改位置之后。
    vim.api.nvim_set_current_line(line)

    -- local buf = vim.api.nvim_get_current_buf()
    -- local start_line = cursor[1] - 1
    -- local end_line = cursor[1]
    -- vim.notify(start_line .. end_line)

    -- vim.api.nvim_buf_set_lines(buf, start_line, end_line, false, { line })

    -- 将游标定位到结果之后，以便用户能继续编辑。
    -- # 用于获取字符串 / 数组的长度
    local new_cursor_pos = #tostring(result) + (line:find(tostring(result)) - 1)
    vim.api.nvim_win_set_cursor(0, { cursor[1], new_cursor_pos })

    return true -- 返回true表示替换成功执行了。
  else
    return false -- 返回false表示没有找到要替换的内容。
  end
end

return M
