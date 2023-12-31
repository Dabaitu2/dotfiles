local status, telescope = pcall(require, 'telescope')
if not status then
  vim.notify('telescope is not found!')
  return
end

telescope.setup({
  defaults = {
    -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
    initial_mode = 'normal',
    -- 窗口内快捷键
    mappings = require('keybindings').telescopeList,
  },
  pickers = {
    -- 内置 pickers 配置
    find_files = {
      -- 查找文件换皮肤，支持的参数有： dropdown, cursor, ivy
      -- theme = "dropdown",
    },
    buffers = {
      mappings = {
        i = {
          ['<C-d>'] = 'delete_buffer',
        },
        n = {
          ['d'] = 'delete_buffer',
        },
      },
    },
  },
  extensions = {
    -- 扩展插件配置
  },
})

pcall(telescope.load_extension, 'env')
pcall(telescope.load_extension, 'fzf')
