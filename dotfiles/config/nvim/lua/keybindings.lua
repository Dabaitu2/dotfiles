---@diagnostic disable: undefined-global
vim.g.mapleader = ';'
vim.g.maplocalleader = ';'

local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = true }
local reopt = { noremap = false, silent = true }

map('i', 'jj', '<ESC>', opt)
map('n', '<C-s>', ':w!<CR>', opt)
-- windows 分屏快捷键
map('n', 'sv', ':vsp<CR>', opt)
map('n', 'sh', ':sp<CR>', opt)
-- 关闭当前
map('n', 'sc', '<C-w>c', opt)
-- 关闭其他
map('n', 'so', '<C-w>o', opt)
-- Alt + hjkl  窗口之间跳转
map('n', '<A-h>', '<C-w>h', opt)
map('n', '<A-j>', '<C-w>j', opt)
map('n', '<A-k>', '<C-w>k', opt)
map('n', '<A-l>', '<C-w>l', opt)

-- 左右比例控制
map('n', '<C-Left>', ':vertical resize -2<CR>', opt)
map('n', '<C-Right>', ':vertical resize +2<CR>', opt)
map('n', 's,', ':vertical resize -20<CR>', opt)
map('n', 's.', ':vertical resize +20<CR>', opt)
-- 上下比例
map('n', 'sj', ':resize +10<CR>', opt)
map('n', 'sk', ':resize -10<CR>', opt)
map('n', '<C-Down>', ':resize +2<CR>', opt)
map('n', '<C-Up>', ':resize -2<CR>', opt)
-- 等比例
map('n', 's=', '<C-w>=', opt)
-- terminal相关
-- map('n', '<leader>t', ':sp | terminal<CR>', opt)
-- map('n', '<leader>vt', ':vsp | terminal<CR>', opt)
-- 退出输入模式
map('t', '<Esc>', '<C-\\><C-n>', opt)
-- 使得 terminal 可以在输入模式下切换窗口
map('t', '<A-h>', [[ <C-\><C-N><C-w>h ]], opt)
map('t', '<A-j>', [[ <C-\><C-N><C-w>j ]], opt)
map('t', '<A-k>', [[ <C-\><C-N><C-w>k ]], opt)
map('t', '<A-l>', [[ <C-\><C-N><C-w>l ]], opt)

-- visual模式下缩进代码
map('v', '<', '<gv', opt)
map('v', '>', '>gv', opt)
-- 上下移动选中文本
map('v', 'J', ":move '>+1<CR>gv-gv", opt)
map('v', 'K', ":move '<-2<CR>gv-gv", opt)

-- 复制到剪贴板
vim.api.nvim_set_keymap('v', '<c-c>', '"+y', opt)

-- 上下滚动浏览
map('n', '<C-j>', '4j', opt)
map('n', '<C-k>', '4k', opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map('n', '<C-u>', '9k', opt)
map('n', '<C-d>', '9j', opt)

-- insert 模式下，跳到行首行尾
map('i', '<C-a>', '<ESC>I', opt)
map('i', '<C-e>', '<ESC>A', opt)

-- Y 复制到剪贴板
map('v', 'Y', '"+y', opt)

-- nvim-tree
-- leader + e 打开关闭 tree
map('n', '<leader>e', ':NvimTreeToggle<CR>', opt)
map('n', '<leader>a', ':NvimTreeFocus<CR>', opt)
map('n', '<C-Right>', ':NvimTreeResize +1<CR>', opt)
map('n', '<C-Left>', ':NvimTreeResize -1<CR>', opt)

-- bufferline
-- tab 左右切换
map('n', '<C-h>', ':BufferLineCyclePrev<CR>', opt)
map('n', '<C-l>', ':BufferLineCycleNext<CR>', opt)
-- 关闭
--"moll/vim-bbye"
map('n', '<A-w>', ':Bdelete!<CR>', opt)
map('n', '<leader>bl', ':BufferLineCloseRight<CR>', opt)
map('n', '<leader>bh', ':BufferLineCloseLeft<CR>', opt)
map('n', '<leader>bc', ':BufferLinePickClose<CR>', opt)
map('n', '<leader>1', ':BufferLineGoToBuffer1<CR>', opt)
map('n', '<leader>2', ':BufferLineGoToBuffer2<CR>', opt)
map('n', '<leader>3', ':BufferLineGoToBuffer3<CR>', opt)
map('n', '<leader>4', ':BufferLineGoToBuffer4<CR>', opt)
map('n', '<leader>5', ':BufferLineGoToBuffer5<CR>', opt)
map('n', '<leader>6', ':BufferLineGoToBuffer6<CR>', opt)
map('n', '<leader>7', ':BufferLineGoToBuffer7<CR>', opt)
map('n', '<leader>8', ':BufferLineGoToBuffer8<CR>', opt)
map('n', '<leader>9', ':BufferLineGoToBuffer9<CR>', opt)
map('n', '<leader>9', ':BufferLineGoToBuffer10<CR>', opt)

-- telescope
-- 查找文件
map('n', '<leader>p', ':Telescope find_files<CR>', opt)
-- 查找文件包括隐藏
map('n', '<leader>h', ':Telescope find_files hidden=true no_ignore=true<CR>', opt)
-- buffer 搜索
map('n', '<leader>f', ':Telescope current_buffer_fuzzy_find ignore_case=true<CR>', opt)
-- 全局搜索
map('n', '<leader>g', ':Telescope live_grep<CR>', opt)
-- buffer list
map('n', '<leader>b', ':Telescope buffers<CR>', opt)
map('n', '<leader>s', ':Telescope grep_string<CR>', opt)
map('n', '<leader>m', ':Telescope marks<CR>', opt)

-- nvim Tree
vim.keymap.set('n', '<leader>mn', require('nvim-tree.api').marks.navigate.next)
vim.keymap.set('n', '<leader>mp', require('nvim-tree.api').marks.navigate.prev)
vim.keymap.set('n', '<leader>ms', require('nvim-tree.api').marks.navigate.select)

-- 插件快捷键
local pluginKeys = {}
-- 列表快捷键
pluginKeys.nvimTreeList = {
  -- 打开文件或文件夹
  { key = { '<CR>', 'o', '<2-LeftMouse>' }, action = 'edit' },
  -- 分屏打开文件
  { key = 'v', action = 'vsplit' },
  { key = 'h', action = 'split' },
  -- 显示隐藏文件
  { key = 'i', action = 'toggle_custom' }, -- 对应 filters 中的 custom (node_modules)
  -- 文件操作
  { key = 'a', action = 'create' },
  { key = 'd', action = 'remove' },
  { key = 'r', action = 'rename' },
  { key = 'x', action = 'cut' },
  { key = 'c', action = 'copy' },
  { key = 'p', action = 'paste' },
  { key = 's', action = 'system_open' },
}

pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    ['<C-j>'] = 'move_selection_next',
    ['<C-k>'] = 'move_selection_previous',
    ['<Down>'] = 'move_selection_next',
    ['<Up>'] = 'move_selection_previous',
    -- 历史记录
    ['<C-n>'] = 'cycle_history_next',
    ['<C-p>'] = 'cycle_history_prev',
    -- 关闭窗口
    ['<C-c>'] = 'close',
    -- 预览窗口上下滚动
    ['<C-u>'] = 'preview_scrolling_up',
    ['<C-d>'] = 'preview_scrolling_down',
  },
}

-- nvim-dap
pluginKeys.mapDAP = function()
  -- 开始
  map('n', '<leader>dd', ':RustDebuggables<CR>', opt)
  -- 结束 (dapui无法自动关闭可能是bug，手动关闭能想到的一切)
  map(
    'n',
    '<leader>de',
    ":lua require'dap'.close()<CR>"
      .. ":lua require'dap'.terminate()<CR>"
      .. ":lua require'dap.repl'.close()<CR>"
      .. ":lua require'dapui'.close()<CR>"
      .. ":lua require('dap').clear_breakpoints()<CR>"
      .. '<C-w>o<CR>',
    opt
  )
  -- 继续
  map('n', '<leader>dc', ":lua require'dap'.continue()<CR>", opt)
  -- 设置断点
  map('n', '<leader>dt', ":lua require('dap').toggle_breakpoint()<CR>", opt)
  map('n', '<leader>dT', ":lua require('dap').clear_breakpoints()<CR>", opt)
  --  stepOver, stepOut, stepInto
  map('n', '<leader>dj', ":lua require'dap'.step_over()<CR>", opt)
  map('n', '<leader>dk', ":lua require'dap'.step_out()<CR>", opt)
  map('n', '<leader>dl', ":lua require'dap'.step_into()<CR>", opt)
  -- 弹窗
  map('n', '<leader>dh', ":lua require'dapui'.eval()<CR>", opt)
end

-- 自定义 toggleterm 3个不同类型的命令行窗口
-- <leader>ta 浮动
-- <leader>tb 右侧
-- <leader>tc 下方
-- 特殊lazygit 窗口，需要安装lazygit
-- <leader>tg lazygit
-- <leader>tn 新建 terminal
-- <leader>tl 显示 terminal 列表
-- <leader>ts 切换 terminal
pluginKeys.mapToggleTerm = function(toggleterm)
  vim.keymap.set({ 'n', 't' }, '<leader>t', toggleterm.toggleC)
  vim.keymap.set({ 'n', 't' }, '<leader>ta', toggleterm.toggleA)
  vim.keymap.set({ 'n', 't' }, '<leader>tb', toggleterm.toggleB)
  vim.keymap.set({ 'n', 't' }, '<leader>tc', toggleterm.toggleC)
  vim.keymap.set({ 'n', 't' }, '<leader>tg', toggleterm.toggleG)
  vim.keymap.set({ 'n', 't' }, '<leader>1t', toggleterm.toggleT1)
  vim.keymap.set({ 'n', 't' }, '<leader>2t', toggleterm.toggleT2)
  vim.keymap.set({ 'n', 't' }, '<leader>3t', toggleterm.toggleT3)

  -- 新增功能
  vim.keymap.set('n', '<leader>tn', function()
    toggleterm.create_new_terminal({ direction = 'float' })
  end, { desc = '新建浮动 Terminal' })

  vim.keymap.set('n', '<leader>tl', function()
    toggleterm.show_terminal_picker()
  end, { desc = '显示 Terminal 列表' })

  vim.keymap.set('n', '<leader>ts', function()
    toggleterm.show_terminal_picker()
  end, { desc = '切换 Terminal' })

  -- 快速创建不同类型的 terminal
  vim.keymap.set('n', '<leader>th', function()
    toggleterm.create_new_terminal({ direction = 'horizontal' })
  end, { desc = '新建水平 Terminal' })

  vim.keymap.set('n', '<leader>tv', function()
    toggleterm.create_new_terminal({ direction = 'vertical' })
  end, { desc = '新建垂直 Terminal' })

  -- 循环切换 terminal
  vim.keymap.set('n', '<leader>tc', function()
    toggleterm.cycle_terminals()
  end, { desc = '循环切换 Terminal' })

  vim.keymap.set('t', '<leader>tc', function()
    toggleterm.cycle_terminals()
  end, { desc = '循环切换 Terminal' })

  -- 重命名当前 terminal
  vim.keymap.set('n', '<leader>tr', function()
    toggleterm.rename_current_terminal()
  end, { desc = '重命名当前 Terminal' })

  vim.keymap.set('t', '<leader>tr', function()
    toggleterm.rename_current_terminal()
  end, { desc = '重命名当前 Terminal' })
end

pluginKeys.mapNvimCmp = function()
  local opts = { noremap = true, silent = true }

  vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
  vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'gr', '<cmd>Lspsaga finder<CR>')

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

  vim.keymap.set('n', '<leader>qf', vim.diagnostic.open_float)
  vim.keymap.set('n', '<leader>k', '<cmd>Lspsaga show_cursor_diagnostics<CR>', opts)
  -- vim.keymap.set('n', 'gk', vim.diagnostic.goto_prev, opts)
  -- vim.keymap.set('n', 'gj', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', 'gk', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
  vim.keymap.set('n', 'gj', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
end

-- @deprecated
pluginKeys.mapCoc = function()
  local keyset = vim.keymap.set
  -- Auto complete
  function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
  end

  local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
  keyset('i', '<TAB>', 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
  keyset('i', '<S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
  keyset('i', '<CR>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

  keyset('n', 'gk', '<Plug>(coc-diagnostic-prev)', reopt)
  keyset('n', 'gj', '<Plug>(coc-diagnostic-next)', reopt)

  -- Use <c-j> to trigger snippets
  keyset('i', '<c-j>', '<Plug>(coc-snippets-expand-jump)')
  -- Use <c-space> to trigger completion.
  keyset('i', '<A-.>', 'coc#refresh()', { silent = true, expr = true })
  keyset('i', '<C-s>', [[<C-r>=CocActionAsync('showSignatureHelp')<CR>]], { noremap = true, silent = true })

  vim.keymap.set('n', 'gh', ":call CocAction('doHover')<CR>", reopt)
  vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', reopt)
  vim.keymap.set('n', 'gt', '<Plug>(coc-type-definition)', reopt)
  vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', reopt)
  vim.keymap.set('n', 'gr', '<Plug>(coc-references)', reopt)

  vim.keymap.set('x', '<leader>ca', '<Plug>(coc-codeaction-selected)')
  vim.keymap.set('n', '<leader>ca', '<Plug>(coc-codeaction-cursor)')

  vim.keymap.set('n', '<leader>cac', '<Plug>(coc-codeaction)')
  vim.keymap.set('n', '<A-f>', ":call CocAction('format')<CR>", { silent = true })

  -- -- Use K to show documentation in preview window.
  function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
      vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
      vim.fn.CocActionAsync('doHover')
    else
      vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
  end
  keyset('n', 'K', '<CMD>lua _G.show_docs()<CR>', { silent = true })

  --- Symbol renaming.
  keyset('n', '<leader>rn', '<Plug>(coc-rename)', { silent = true })
  keyset(
    'n',
    '<leader>qf',
    [[<cmd> call coc#rpc#request('fillDiagnostics', [bufnr('%')])<CR><cmd>Trouble loclist<CR>]],
    { silent = true }
  )

  -- Remap <C-f> and <C-b> for scroll float windows/popups.
  ---@diagnostic disable-next-line: redefined-local
  local opts = { silent = true, nowait = true, expr = true }
  keyset('n', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
  keyset('n', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
  keyset('i', '<C-f>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
  keyset('i', '<C-b>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
  keyset('v', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
  keyset('v', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('switch_formatter', { clear = true }),
    pattern = 'lua',
    desc = 'switch formatter to stylua when filetype is lua',
    callback = function()
      vim.keymap.set('n', '<A-f>', ":lua require'stylua-nvim'.format_file()<CR>", { silent = true })
    end,
  })

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('switch_runCommand', { clear = true }),
    pattern = 'rust',
    desc = 'switch runCommand to rust-analyzer when filetype is rust',
    callback = function()
      vim.keymap.set('n', '<leader>r', ":call CocAction('runCommand', 'rust-analyzer.run')<CR>", reopt)
    end,
  })

  vim.api.nvim_create_autocmd('FileType', {
    -- group = vim.api.nvim_create_augroup('switch_runCommand', { clear = true }),
    pattern = 'scheme',
    desc = 'switch runCommand to racket when filetype is scheme like',
    callback = function()
      vim.keymap.set('n', '<leader>r', [[:!racket %<CR>]], reopt)
      vim.keymap.set(
        'n',
        '<leader><A-f>',
        [[:!raco fmt --width 60 % > _temp__.rkt && mv _temp__.rkt %]] .. '<CR>',
        reopt
      )
    end,
  })

  vim.api.nvim_create_autocmd('FileType', {
    -- group = vim.api.nvim_create_augroup('switch_runCommand', { clear = true }),
    pattern = 'racket',
    desc = 'switch runCommand to racket when filetype is scheme like',
    callback = function()
      vim.keymap.set('n', '<leader>r', [[:!racket %<CR>]], reopt)
      vim.keymap.set(
        'n',
        '<leader><A-f>',
        [[:!raco fmt --width 60 % > _temp__.rkt && mv _temp__.rkt %]] .. '<CR>',
        reopt
      )
    end,
  })

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('switch_runCommand', { clear = true }),
    pattern = 'go',
    desc = 'switch runCommand to go when filetype is go like',
    callback = function()
      vim.keymap.set('n', 'gtj', [[:call CocAction('runCommand', 'go.tags.add', 'json')<CR>]], reopt)
      vim.keymap.set('n', 'gtt', [[:call CocAction('runCommand', 'go.tags.add', 'thrift')<CR>]], reopt)
      vim.keymap.set('n', 'gtc', [[:call CocAction('runCommand', 'go.tags.clear')<CR>]], reopt)
      vim.keymap.set('n', '<leader>r', [[:!go run %<CR>]], reopt)
      -- vim.api.nvim_create_autocmd('BufWritePre', {
      --   pattern = '*.go',
      --   callback = function()
      --     vim.api.nvim_command([[:silent call CocAction('runCommand', 'editor.action.organizeImport')]])
      --   end,
      -- })
    end,
  })
end

pluginKeys.mapZenMode = function()
  vim.keymap.set('n', '<leader>z', ':ZenMode<CR>')
end

pluginKeys.mapEasyAlign = function()
  vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)')
  vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)')
end

-- vim fugitive
vim.keymap.set('n', '<leader>di', '[[:Git log -p -- %<CR>]]', reopt)

return pluginKeys
