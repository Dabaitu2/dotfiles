local ts = require('nvim-treesitter.ts_utils')
local M = {}

-- TODO: user can specify the deepth
local max_depth = 10
local default_consider_context_types = {
  'declaration',
  'comment',
  'block',
}

local function containsAny(context_string, search_table)
  for _, search_str in ipairs(search_table) do
    if string.find(context_string, search_str) then
      return true
    end
  end
  return false
end

-- 获取当前节点的父节点直到拿不到了
local function get_relevant_node()
  local depth = 1
  local function get_relevant_node_recursive(current_node)
    if containsAny(current_node:type(), default_consider_context_types) then
      return current_node
    elseif depth > max_depth then
      return current_node
    else
      if current_node:parent() then
        depth = depth + 1
        return get_relevant_node_recursive(current_node:parent())
      end
      return current_node
    end
  end

  local current_node = ts.get_node_at_cursor()
  if current_node ~= nil then
    if current_node:type() == 'ERROR' then
      current_node = current_node:prev_sibling()
    end
    return get_relevant_node_recursive(current_node)
  end
end

-- 计算一段文本内的字数
local function count_words_in_text(text_content)
  local count = 0
  -- 使用字符串匹配函数寻找连续的非空格字符
  for _ in text_content:gmatch('%S+') do
    count = count + 1
  end
  return count
end

-- 计算指定 lines 内的字数
local function count_words_in_range(lines)
  local count = 0
  for _, line in ipairs(lines) do
    count = count + count_words_in_text(line)
  end
  return count
end

-- 主函数：获取段落字数并打印结果。
function M.count_paragraph_words()
  local node = get_relevant_node()

  if node then
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line_number = cursor[1]

    local start_row = node:range()
    local lines = vim.api.nvim_buf_get_lines(bufnr, start_row, line_number, false)
    local word_count = count_words_in_range(lines)

    print('Word count in the code segment: ' .. word_count)
  else
    print('No relevant code segment found.')
  end
end

-- 插件设置函数，在这里可以定义命令等。
function M.setup()
  vim.api.nvim_create_user_command(
    'CountParagraphWords',
    M.count_paragraph_words,
    { desc = 'Count words in the code segment under the cursor' }
  )
end

return M
