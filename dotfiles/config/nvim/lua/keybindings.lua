vim.g.mapleader = ';'
vim.g.maplocalleader = ';'

local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = true }
local reopt = { noremap = false, silent = true }

map('i', 'jj', '<ESC>', opt)
map('n', '<C-s>', ':w<CR>', opt)
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

-- ChatGPT
-- 打开窗口
map('n', '<leader>c', ':ChatGPT<CR>', opt)

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

-- LSP 跳转相关 keybindings
pluginKeys.mapLSP = function(mapbuf)
  -- rename
  --[[
  Lspsaga 替换 rn
  mapbuf("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
  --]]
  mapbuf('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', opt)
  -- code action
  -- Lspsaga 替换 ca
  -- mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
  mapbuf('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opt)
  -- go xx
  -- mapbuf('n', 'gd', '<cmd>Lspsaga preview_definition<CR>', opt)
  mapbuf('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
  --[[
  Lspsaga 替换 gh
  mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
  --]]
  mapbuf('n', 'gh', '<cmd>Lspsaga hover_doc<cr>', opt)
  -- mapbuf('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
  --[[
  Lspsaga 替换 gr
  mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
  --]]
  mapbuf('n', 'gr', '<cmd>Lspsaga lsp_finder<CR>', opt)
  --[[
  Lspsaga 替换 gp, gj, gk
  mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
  mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
  mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
  --]]
  -- diagnostic
  mapbuf('n', 'gi', '<cmd>Lspsaga show_line_diagnostics<CR>', opt)
  mapbuf('n', 'gj', '<cmd>Lspsaga diagnostic_jump_next<cr>', opt)
  mapbuf('n', 'gk', '<cmd>Lspsaga diagnostic_jump_prev<cr>', opt)
  mapbuf('n', '<A-f>', '<cmd>lua vim.lsp.buf.formatting({ timeout_ms = 2000 })<CR>', opt)
  -- 未用
  -- mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
  -- mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
  -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
  -- mapbuf("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
  -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
  -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)end
end

pluginKeys.mapTsLSP = function(mapbuf)
  mapbuf('n', '<leader>s', ':TSLspOrganize<CR>', opt)
  mapbuf('n', '<leader>r', ':TSLspRenameFile<CR>', opt)
  mapbuf('n', '<leader>i', ':TSLspImportAll<CR>', opt)
end

pluginKeys.mapRustLSP = function(mapbuf)
  mapbuf('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
end

-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  return {
    -- 出现补�������������������������������������
    ['<A-.>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    -- 取消
    ['<A-,>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- 上一个
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    -- 下一个
    ['<C-j>'] = cmp.mapping.select_next_item(),
    -- 确认
    ['<CR>'] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
    -- 如果窗口内容太多，可以滚动
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),

    -- 自定义代码段跳转到下一个参数
    ['<C-l>'] = cmp.mapping(function(_)
      if vim.fn['vsnip#available'](1) == 1 then
        feedkey('<Plug>(vsnip-expand-or-jump)', '')
      end
    end, { 'i', 's' }),

    -- 自定义代码段跳转到上一个参数
    ['<C-h>'] = cmp.mapping(function()
      if vim.fn['vsnip#jumpable'](-1) == 1 then
        feedkey('<Plug>(vsnip-jump-prev)', '')
      end
    end, { 'i', 's' }),

    -- Super Tab
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn['vsnip#available'](1) == 1 then
        feedkey('<Plug>(vsnip-expand-or-jump)', '')
      elseif has_words_before() then
        -- 如果前面有文本也会尝试 Tab 补全
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn['vsnip#jumpable'](-1) == 1 then
        feedkey('<Plug>(vsnip-jump-prev)', '')
      end
    end, { 'i', 's' }),
    -- end of super Tab
  }
end

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
pluginKeys.mapToggleTerm = function(toggleterm)
  vim.keymap.set({ 'n', 't' }, '<leader>t', toggleterm.toggleC)
  vim.keymap.set({ 'n', 't' }, '<leader>ta', toggleterm.toggleA)
  vim.keymap.set({ 'n', 't' }, '<leader>tb', toggleterm.toggleB)
  vim.keymap.set({ 'n', 't' }, '<leader>tc', toggleterm.toggleC)
  vim.keymap.set({ 'n', 't' }, '<leader>tg', toggleterm.toggleG)
end

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
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.go',
        callback = function()
          vim.api.nvim_command([[:silent call CocAction('runCommand', 'editor.action.organizeImport')]])
        end,
      })
    end,
  })
end

pluginKeys.mapZenMode = function()
  vim.keymap.set('n', '<leader>z', ':ZenMode<CR>')
end

return pluginKeys
