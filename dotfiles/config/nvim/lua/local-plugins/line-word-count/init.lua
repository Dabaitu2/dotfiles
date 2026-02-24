local M = {}

-- Default configuration
local config = {
  highlight_group = 'LineWordCount',
  prefix = 'Words: ',
  suffix = '',
  update_events = { 'InsertLeave', 'TextChanged', 'BufEnter', 'CursorMoved' },
}

-- Virtual text namespace
local namespace = vim.api.nvim_create_namespace('line-word-count')

-- Calculate word count for current line
local function count_words()
  local line = vim.api.nvim_get_current_line()
  -- Remove leading/trailing whitespace
  line = line:gsub('^%s+', ''):gsub('%s+$', '')

  -- Handle empty line
  if line == '' then
    return 0
  end

  -- Split into words using whitespace as delimiter
  local words = {}
  for word in line:gmatch('%S+') do
    table.insert(words, word)
  end

  return #words
end

-- Update virtual text display
local function update_virtual_text()
  -- Clear existing virtual text
  vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)

  local word_count = count_words()
  if word_count == 0 then
    return
  end

  local text = config.prefix .. word_count .. config.suffix
  local line = vim.api.nvim_win_get_cursor(0)[1] - 1 -- 0-indexed
  local line_length = vim.api.nvim_get_current_line():len()

  -- Add virtual text at the end of the line
  vim.api.nvim_buf_set_extmark(0, namespace, line, line_length, {
    virt_text = { { text, config.highlight_group } },
    virt_text_pos = 'eol',
    hl_mode = 'combine',
  })
end

-- Setup function with user configuration
function M.setup(user_config)
  -- Merge user configuration with defaults
  if user_config then
    for k, v in pairs(user_config) do
      config[k] = v
    end
  end

  -- Create highlight group if it doesn't exist
  if not vim.api.nvim_get_hl_id_by_name(config.highlight_group) then
    vim.api.nvim_set_hl(0, config.highlight_group, {
      fg = '#808080', -- Gray color
      bg = 'NONE',
      italic = true,
    })
  end

  -- Set up autocommands
  local group = vim.api.nvim_create_augroup('LineWordCount', { clear = true })
  vim.api.nvim_create_autocmd(config.update_events, {
    group = group,
    pattern = '*',
    callback = update_virtual_text,
  })

  -- Initial update
  update_virtual_text()
end

return M
