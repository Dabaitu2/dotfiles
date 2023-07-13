local status, bufferline = pcall(require, 'bufferline')
if not status then
  vim.notify('bufferline is not found!')
  return
end

bufferline.setup({
  options = {
    close_command = 'Bdelete! %d',
    right_mouse_command = 'Bdelete! %d',
    -- 侧边栏配置
    -- 左侧让出 nvim-tree 的位置，显示文字 File Explorer
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'File Explorer',
        highlight = 'Directory',
        text_align = 'left',
      },
    },
    diagnostics = 'coc',
    -- 将报错信息转化为图标
    ---@diagnostic disable-next-line: unused-local
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = ' '
      for e, n in pairs(diagnostics_dict) do
        local sym = e == 'error' and ' ' or (e == 'warning' and ' ' or ' ')
        s = s .. n .. sym
      end
      return s
    end,
  },
})
