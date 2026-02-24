-- 如果找不到lualine 组件，就不继续执行
local status, lualine = pcall(require, 'lualine')
if not status then
  vim.notify('lualine is not found!')
  return
end

-- local nvim_tree_shift = {
--   function()
--     return string.rep(' ', vim.api.nvim_win_get_width(require('nvim-tree.view').get_winnr()) - 1)
--   end,
--   local ok, view = pcall(require, "nvim-tree.view")
--   if ok and view then
--     cond = view.is_visible
--   color = 'NvimTreeNormal'
--     end
-- }

-- local function breadcrumbs()
--   local items = vim.b.coc_nav
--   local t = { '' }
--   for k, v in ipairs(items) do
--     setmetatable(v, {
--       __index = function(table, key)
--         return ' '
--       end,
--     })
--     t[#t + 1] = ' %#' .. v.highlight .. '#' .. v.label .. v.name
--     if next(items, k) ~= nil then
--       t[#t + 1] = ' '
--     end
--   end
--   return table.concat(t)
-- end

local function empty()
  return [[ ]]
end

-- 自定义 toggleterm 组件，显示当前终端的自定义名称
local function custom_toggleterm_component()
  -- 获取 toggleterm 模块
  local toggleterm_ok, toggleterm = pcall(require, 'plugin-config.toggleterm')
  if not toggleterm_ok then
    return ''
  end

  -- 获取当前 buffer 的 terminal ID
  local current_bufnr = vim.api.nvim_get_current_buf()
  local terminals = toggleterm.get_all_terminals()

  for _, term_info in ipairs(terminals) do
    if term_info.terminal.bufnr == current_bufnr then
      -- 返回自定义名称或默认名称
      return term_info.display_name
    end
  end

  return ''
end

-- 增强版自定义 toggleterm 组件（带状态图标和方向指示）
local function enhanced_toggleterm_component()
  local toggleterm_ok, toggleterm = pcall(require, 'plugin-config.toggleterm')
  if not toggleterm_ok then
    return ''
  end

  local current_bufnr = vim.api.nvim_get_current_buf()
  local terminals = toggleterm.get_all_terminals()

  for _, term_info in ipairs(terminals) do
    if term_info.terminal.bufnr == current_bufnr then
      -- 添加状态指示器
      local status_icon = term_info.is_open and "●" or "○"
      local direction_icon = ""

      if term_info.direction == 'float' then
        direction_icon = "󰉬 "  -- 浮动窗口图标
      elseif term_info.direction == 'vertical' then
        direction_icon = "󰧮 "  -- 垂直分割图标
      elseif term_info.direction == 'horizontal' then
        direction_icon = "󰧯 "  -- 水平分割图标
      end

      return string.format("%s %s%s", status_icon, direction_icon, term_info.display_name)
    end
  end

  return ''
end

-- 简洁版自定义 toggleterm 组件（只显示名称）
local function simple_toggleterm_component()
  local toggleterm_ok, toggleterm = pcall(require, 'plugin-config.toggleterm')
  if not toggleterm_ok then
    return ''
  end

  local current_bufnr = vim.api.nvim_get_current_buf()
  local terminals = toggleterm.get_all_terminals()

  for _, term_info in ipairs(terminals) do
    if term_info.terminal.bufnr == current_bufnr then
      return term_info.display_name
    end
  end

  return ''
end

lualine.setup({
  options = {
    -- theme = 'tokyonight',
    -- theme = 'carbonfox',
    theme = 'catppuccin',
    -- https://github.com/ryanoasis/powerline-extra-symbols
    -- component_separators = { left = '|', right = '|' },
    -- section_separators = { left = '', right = '' },
    -- component_separators = '|',
    component_separators = '',
    section_separators = { left = '', right = ' ' },
    disabled_filetypes = {
      winbar = { 'NvimTree', 'packer', 'dashboard', 'racket', 'scheme', 'toggleterm' },
      -- statusline = { 'NvimTree' },
    },
    globalstatus = true,
    refresh = {
      winbar = 200,
      statusline = 300,
    },
  },
  extensions = {
    'nvim-tree',
    -- 使用自定义的 toggleterm 扩展
    -- 可选版本：
    -- enhanced_toggleterm_component: 显示状态图标 + 方向图标 + 自定义名称
    -- simple_toggleterm_component: 只显示自定义名称
    -- custom_toggleterm_component: 基础版本，功能同 simple
    {
      sections = {
        lualine_a = { enhanced_toggleterm_component },
      },
      inactive_sections = {
        lualine_a = { enhanced_toggleterm_component },
      },
      filetypes = { 'toggleterm' }
    },
  },
  sections = {
    lualine_a = {
      -- nvim_tree_shift,
      { 'mode', separator = { left = '', right = '' } },
    },
    lualine_b = {
      { empty, draw_empty = true, color = { bg = 'NONE' }, padding = { left = 0, right = 0 } },
      { 'branch', separator = { left = '', right = '' } },
    },
    lualine_c = {
      { empty, draw_empty = true, color = { bg = 'NONE' }, padding = { left = 0, right = 0 } },
      {
        'diagnostic',
        draw_empty = true,
        -- color = { bg = '#181825' },
        padding = 2,
        separator = '█',
        sources = { 'coc' },
      },
      {
        'g:coc_status',
        -- draw_empty = true,
        separator = { right = '', left = '' },
        padding = {
          left = 0,
          right = 1,
        },
        color = {
          bg = '#b1dea5',
          fg = '#181825',
          gui = 'bold',
        },
      },
    },
    lualine_x = {
      {
        'filesize',
        separator = { left = '', right = '' },
      },
      {
        'fileformat',
        symbols = {
          unix = '', -- e712
          dos = '', -- e70f
          mac = '', -- e711
        },
        -- symbols = {
        --   unix = 'LF',
        --   dos = 'CRLF',
        --   mac = 'CR',
        -- },
      },
      'encoding',
      'filetype',
    },
    lualine_y = {
      { 'progress', separator = { left = '' }, padding = { right = 2, left = 1 } },
    },
    lualine_z = {
      { 'location', separator = { right = '' }, padding = { left = 1 } },
    },
  },
  winbar = {
    -- lualine_b = {
    --   -- {
    --   --   'filename',
    --   --   separator = { left = '', right = '' },
    --   --   padding = { left = 4, right = 0 },
    --   --   color = function()
    --   --     return { bg = 'NONE', fg = '#7E7F80' }
    --   --   end,
    --   --   -- icon,
    -- },
    -- lualine_c = { { breadcrumbs, separator = nil } },
  },
  inactive_winbar = {
    -- lualine_b = {
    --   {
    --     'filename',
    --     separator = { left = '', right = '' },
    --     padding = { left = 4, right = 1 },
    --     color = function()
    --       -- return { bg = 'NONE', fg = '#7E7F80' }
    --     end,
    --     icon,
    --   },
    -- },
    -- lualine_c = { { breadcrumbs, separator = nil } },
  },
})
