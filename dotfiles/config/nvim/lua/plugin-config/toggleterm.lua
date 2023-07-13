---@diagnostic disable: missing-parameter
local status, toggleterm = pcall(require, 'toggleterm')
if not status then
  vim.notify('没有找到 toggleterm')
  return
end

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = 'lazygit',
  dir = 'git_dir',
  direction = 'float',
  float_opts = {
    border = 'double',
  },
  on_open = function(term)
    vim.cmd('startinsert!')
    -- q / <leader>tg 关闭 terminal
    vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term.bufnr, 'n', '<leader>tg', '<cmd>close<CR>', { noremap = true, silent = true })
    -- ESC 键取消，留给lazygit
    if vim.fn.mapcheck('<Esc>', 't') ~= '' then
      vim.api.nvim_del_keymap('t', '<Esc>')
    end
  end,
  on_close = function(_)
    -- 添加回来
    vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {
      noremap = true,
      silent = true,
    })
  end,
})

toggleterm.setup({
  open_mapping = [[<c-\>]],
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end,
  on_open = function(terminal)
    local nvimtree = require('nvim-tree')
    local nvimtree_view = require('nvim-tree.view')
    if nvimtree_view.is_visible() and terminal.direction == 'horizontal' then
      local nvimtree_width = vim.fn.winwidth(nvimtree_view.get_winnr())
      nvimtree.api.tree.toggle()
      nvimtree_view.View.width = nvimtree_width
      nvimtree.api.tree.toggle(false, true)
    end
  end,
})

local ta = Terminal:new({
  direction = 'float',
  close_on_exit = true,
})

local tb = Terminal:new({
  direction = 'vertical',
  close_on_exit = true,
})

local tc = Terminal:new({
  direction = 'horizontal',
  close_on_exit = true,
  on_open = function(terminal)
    local nvimtree = require('nvim-tree.api')
    local nvimtree_view = require('nvim-tree.view')
    if nvimtree_view.is_visible() and terminal.direction == 'horizontal' then
      local nvimtree_width = vim.fn.winwidth(nvimtree_view.get_winnr())
      nvimtree.tree.toggle()
      nvimtree_view.View.width = nvimtree_width
      nvimtree.tree.toggle(false, true)
    end
  end,
})

local M = {}

M.toggleA = function()
  if ta:is_open() then
    ta:close()
    return
  end
  tb:close()
  tc:close()
  ta:open()
end

M.toggleB = function()
  if tb:is_open() then
    tb:close()
    return
  end
  ta:close()
  tc:close()
  tb:open()
end

M.toggleC = function()
  if tc:is_open() then
    tc:close()
    return
  end
  ta:close()
  tb:close()
  tc:open()
end

M.toggleG = function()
  lazygit:toggle()
end

require('keybindings').mapToggleTerm(M)
