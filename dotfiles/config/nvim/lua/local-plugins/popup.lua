local M = {}

---@param lines table
function M.show_popup(lines)
  local bufnr = vim.api.nvim_create_buf(false, true) -- 创建buffer
  local width = 50
  local height = 27
  local win_width = vim.api.nvim_get_option('columns')
  local win_height = vim.api.nvim_get_option('lines')

  -- 计算居中位置
  local col = math.ceil((win_width - width) / 2)
  local row = math.ceil((win_height - height) / 2 - 1)

  -- 创建浮动窗口配置选项
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    anchor = 'NW',
    style = 'minimal',
    border = 'rounded',
  }

  -- 创建浮动窗口
  vim.api.nvim_open_win(bufnr, true, opts)

  table.insert(lines, 'Press <Esc> to close')
  -- 往buffer里写内容
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

  -- 设置按键映射以便关闭浮动窗口
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Esc>', '<cmd>bd!<CR>', { noremap = true, silent = true })
end

vim.api.nvim_create_user_command('ShowPopUp', function()
  M.show_popup({ 'This is a popup' })
end, { nargs = '*' })

return M
