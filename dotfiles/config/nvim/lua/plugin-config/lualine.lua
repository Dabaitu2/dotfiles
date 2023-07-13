-- 如果找不到lualine 组件，就不继续执行
local status, lualine = pcall(require, 'lualine')
if not status then
  vim.notify('lualine is not found!')
  return
end

local function breadcrumbs()
  local items = vim.b.coc_nav
  local t = { '' }
  for k, v in ipairs(items) do
    setmetatable(v, {
      __index = function(table, key)
        return ' '
      end,
    })
    t[#t + 1] = ' %#' .. v.highlight .. '#' .. v.label .. v.name
    if next(items, k) ~= nil then
      t[#t + 1] = ' '
    end
  end
  return table.concat(t)
end

lualine.setup({
  options = {
    -- theme = 'tokyonight',
    theme = 'carbonfox',
    component_separators = { left = '|', right = '|' },
    -- https://github.com/ryanoasis/powerline-extra-symbols
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      winbar = { 'NvimTree', 'packer', 'dashboard', 'racket', 'scheme', 'toggleterm' },
    },
    refresh = {
      winbar = 200,
      statusline = 300,
    },
  },
  extensions = { 'nvim-tree', 'toggleterm' },
  sections = {
    lualine_c = {
      {
        'diagnostic',
        sources = { 'coc' },
      },
      'g:coc_status',
    },
    lualine_x = {
      'filesize',
      {
        'fileformat',
        -- symbols = {
        --   unix = '', -- e712
        --   dos = '', -- e70f
        --   mac = '', -- e711
        -- },
        symbols = {
          unix = 'LF',
          dos = 'CRLF',
          mac = 'CR',
        },
      },
      'encoding',
      'filetype',
    },
  },
  winbar = {
    lualine_b = {
      {
        'filename',
        separator = { left = '', right = '' },
        padding = { left = 4, right = 1 },
        -- color = function()
        -- return { bg = 'NONE', fg = '#7E7F80' }
        -- end,
        icon,
      },
    },
    lualine_c = { { breadcrumbs, separator = nil } },
  },
  inactive_winbar = {
    lualine_b = {
      {
        'filename',
        separator = { left = '', right = '' },
        padding = { left = 4, right = 1 },
        color = function()
          -- return { bg = 'NONE', fg = '#7E7F80' }
        end,
        icon,
      },
    },
    lualine_c = { { breadcrumbs, separator = nil } },
  },
})
