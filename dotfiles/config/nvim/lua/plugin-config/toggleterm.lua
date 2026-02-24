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
    local api = require('nvim-tree.api')
    if api.tree.is_visible() and terminal.direction == 'horizontal' then
      api.tree.close()
      api.tree.open()
    end
  end,
})

local terminals = {}
local terminal_counter = 0
local terminal_names = {} -- 存储终端自定义名称

-- 将 ta, tb, tc 添加到 terminals 表中
local ta = Terminal:new({
  direction = 'float',
  close_on_exit = true,
})
terminals['ta'] = ta

local tb = Terminal:new({
  direction = 'vertical',
  close_on_exit = true,
})
terminals['tb'] = tb

local tc = Terminal:new({
  direction = 'horizontal',
  close_on_exit = true,
  on_open = function(terminal)
    local api = require('nvim-tree.api')
    if api.tree.is_visible() and terminal.direction == 'horizontal' then
      api.tree.close()
      api.tree.open()
    end
  end,
})
terminals['tc'] = tc
terminals['lazygit'] = lazygit

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

local terminal_names = {} -- 存储终端自定义名称

local function get_or_create_terminal(id, opts)
  if not terminals[id] then
    terminals[id] = Terminal:new(vim.tbl_extend('force', {
      direction = 'float',
      close_on_exit = true,
    }, opts or {}))
  end
  return terminals[id]
end

M.toggle_term = function(id, opts)
  local term = get_or_create_terminal(id, opts)
  if term:is_open() then
    term:close()
  else
    term:open()
  end
end

-- 创建新的 terminal
M.create_new_terminal = function(opts)
  opts = opts or {}
  terminal_counter = terminal_counter + 1
  local id = "term_" .. terminal_counter

  -- 如果提供了名称，保存为自定义名称
  if opts.name then
    terminal_names[id] = opts.name
  end

  local term = get_or_create_terminal(id, opts)
  term:open()
  return id, term
end

-- 获取所有未退出的 terminal 列表（包括隐藏的）
M.get_all_terminals = function()
  local all_terms = {}
  for id, term in pairs(terminals) do
    -- 检查终端进程是否还在运行（未退出）
    local is_running = term.job_id and vim.fn.jobpid(term.job_id) ~= 0
    if is_running or term:is_open() then
      local custom_name = terminal_names[id]
      local display_name = custom_name or (type(id) == "string" and id:gsub("^term_", "Terminal ") or ("Terminal " .. id))
      table.insert(all_terms, {
        id = id,
        terminal = term,
        direction = term.direction,
        display_name = display_name,
        is_open = term:is_open(),
        is_running = is_running,
        custom_name = custom_name
      })
    end
  end
  return all_terms
end

-- 获取所有打开的 terminal 列表（已弃用，用 get_all_terminals 替代）
M.get_open_terminals = function()
  local open_terms = {}
  for id, term in pairs(terminals) do
    if term:is_open() then
      local custom_name = terminal_names[id]
      local display_name = custom_name or (type(id) == "string" and id:gsub("^term_", "Terminal ") or ("Terminal " .. id))
      table.insert(open_terms, {
        id = id,
        terminal = term,
        direction = term.direction,
        display_name = display_name,
        custom_name = custom_name
      })
    end
  end
  return open_terms
end

-- 切换到指定 terminal
M.switch_to_terminal = function(id)
  local term = terminals[id]
  if term then
    if term:is_open() then
      term:focus()
    else
      -- 如果终端存在但未打开，重新打开它
      term:open()
    end
    return true
  end
  return false
end

-- 关闭指定 terminal
M.close_terminal = function(id)
  local term = terminals[id]
  if term and term:is_open() then
    term:close()
    return true
  end
  return false
end

-- 循环切换到下一个 terminal
M.cycle_terminals = function()
  local all_terms = M.get_all_terminals()
  if #all_terms == 0 then
    vim.notify("没有未退出的 terminal", vim.log.levels.INFO)
    return
  end

  -- 获取当前 buffer 的 terminal ID
  local current_bufnr = vim.api.nvim_get_current_buf()
  local current_term_id = nil

  for id, term in pairs(terminals) do
    if term.bufnr == current_bufnr then
      current_term_id = id
      break
    end
  end

  -- 找到当前 terminal 在列表中的位置
  local current_index = 0
  for i, term_info in ipairs(all_terms) do
    if term_info.id == current_term_id then
      current_index = i
      break
    end
  end

  -- 切换到下一个 terminal
  local next_index = current_index + 1
  if next_index > #all_terms then
    next_index = 1
  end

  M.switch_to_terminal(all_terms[next_index].id)
end

-- 重命名 terminal
M.rename_terminal = function(id, new_name)
  if not terminals[id] then
    vim.notify("Terminal " .. id .. " 不存在", vim.log.levels.WARN)
    return false
  end

  terminal_names[id] = new_name
  vim.notify("Terminal 已重命名为: " .. new_name, vim.log.levels.INFO)
  return true
end

-- 交互式重命名当前 terminal
M.rename_current_terminal = function()
  -- 获取当前 buffer 的 terminal ID
  local current_bufnr = vim.api.nvim_get_current_buf()
  local current_term_id = nil

  for id, term in pairs(terminals) do
    if term.bufnr == current_bufnr then
      current_term_id = id
      break
    end
  end

  if not current_term_id then
    vim.notify("当前 buffer 不是 terminal", vim.log.levels.WARN)
    return
  end

  local current_name = terminal_names[current_term_id] or (type(current_term_id) == "string" and current_term_id:gsub("^term_", "Terminal ") or ("Terminal " .. current_term_id))
  local new_name = vim.fn.input("重命名 Terminal (当前: " .. current_name .. "): ")

  if new_name and new_name ~= "" then
    M.rename_terminal(current_term_id, new_name)
  end
end

M.toggleT1 = function()
  M.toggle_term(1, {
    direction = 'horizontal',
  })
end

M.toggleT2 = function()
  M.toggle_term(2, {
    direction = 'horizontal',
  })
end

M.toggleT3 = function()
  M.toggle_term(3, {
    direction = 'horizontal',
  })
end

-- Telescope 集成 - 显示 terminal 列表
M.show_terminal_picker = function()
  local all_terms = M.get_all_terminals()

  if #all_terms == 0 then
    vim.notify("没有未退出的 terminal", vim.log.levels.INFO)
    return
  end

  -- 检查 telescope 是否可用
  local telescope_ok, telescope = pcall(require, "telescope")
  if not telescope_ok then
    vim.notify("Telescope 未安装，无法显示 terminal 列表", vim.log.levels.WARN)
    -- 简单的文本列表作为备选方案
    local term_list = {}
    for i, term_info in ipairs(all_terms) do
      local status = term_info.is_open and "打开" or "隐藏"
      table.insert(term_list, string.format("%d. %s (%s) [%s]", i, term_info.display_name, term_info.direction, status))
    end

    local choice = vim.fn.inputlist(vim.tbl_extend(1, {"选择要切换的 Terminal:"}, term_list))
    if choice > 0 and choice <= #all_terms then
      M.switch_to_terminal(all_terms[choice].id)
    end
    return
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local entry_display = require("telescope.pickers.entry_display")

  local displayer = entry_display.create({
    separator = " ",
    items = {
      { width = 12 },
      { width = 10 },
      { width = 8 },
      { remaining = true },
    },
  })

  local function make_display(entry)
    local status = entry.value.is_open and "打开" or "隐藏"
    return displayer({
      { entry.value.display_name, "Type" },
      { entry.value.direction, "Comment" },
      { status, entry.value.is_open and "String" or "Comment" },
      { tostring(entry.value.id), "Comment" },
    })
  end

  local entries = {}
  for _, term_info in ipairs(all_terms) do
    table.insert(entries, {
      value = term_info,
      display = make_display,
      ordinal = term_info.display_name .. " " .. term_info.direction,
    })
  end

  pickers.new({}, {
    prompt_title = "Terminal List (包含隐藏终端) - <C-r>重命名, <C-d>关闭",
    finder = finders.new_table({
      results = entries,
      entry_maker = function(entry)
        return entry
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      -- 默认回车行为
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then
          M.switch_to_terminal(selection.value.id)
        end
      end)

      -- 空格键切换打开/隐藏
      map('i', '<Space>', function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then
          M.toggle_term(selection.value.id)
        end
      end)

      map('n', '<Space>', function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then
          M.toggle_term(selection.value.id)
        end
      end)

      -- 添加删除快捷键
      map('i', '<C-d>', function()
        local selection = action_state.get_selected_entry()
        if selection then
          M.close_terminal(selection.value.id)
          -- 重新打开 picker
          actions.close(prompt_bufnr)
          M.show_terminal_picker()
        end
      end)

      map('n', '<C-d>', function()
        local selection = action_state.get_selected_entry()
        if selection then
          M.close_terminal(selection.value.id)
          -- 重新打开 picker
          actions.close(prompt_bufnr)
          M.show_terminal_picker()
        end
      end)

      -- 添加重命名快捷键
      map('i', '<C-r>', function()
        local selection = action_state.get_selected_entry()
        if selection then
          actions.close(prompt_bufnr)
          local current_name = selection.value.custom_name or selection.value.id:gsub("^term_", "Terminal ")
          local new_name = vim.fn.input("重命名 Terminal (当前: " .. current_name .. "): ")
          if new_name and new_name ~= "" then
            M.rename_terminal(selection.value.id, new_name)
          end
          -- 重新打开 picker
          M.show_terminal_picker()
        end
      end)

      map('n', '<C-r>', function()
        local selection = action_state.get_selected_entry()
        if selection then
          actions.close(prompt_bufnr)
          local current_name = selection.value.custom_name or selection.value.id:gsub("^term_", "Terminal ")
          local new_name = vim.fn.input("重命名 Terminal (当前: " .. current_name .. "): ")
          if new_name and new_name ~= "" then
            M.rename_terminal(selection.value.id, new_name)
          end
          -- 重新打开 picker
          M.show_terminal_picker()
        end
      end)

      return true
    end,
  }):find()
end

require('keybindings').mapToggleTerm(M)

return M
