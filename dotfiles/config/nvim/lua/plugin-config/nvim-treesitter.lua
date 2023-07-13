local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then
  vim.notify('没有找到 nvim-treesitter')
  return
end

-- orgmode
require('orgmode').setup_ts_grammar()

treesitter.setup({
  -- 安装 language parser
  -- :TSInstallInfo 命令查看支持的语言
  ensure_installed = {
    'json',
    'html',
    'css',
    'vim',
    'lua',
    'javascript',
    'typescript',
    'tsx',
    'rust',
    'vue',
    'toml',
    'org',
  },
  -- 启用代码高亮模块
  highlight = {
    enable = true,
    disable = { 'thrift' },
    -- 关闭 vim 的正则语法高亮
    additional_vim_regex_highlighting = { 'org' },
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    disable = { 'jsx', 'tsx', 'html', 'org' },
  },
  -- 启用增量选择模块
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      node_decremental = '<BS>',
      scope_incremental = '<TAB>',
    },
  },
  -- 启用代码缩进模块 (=)
  indent = {
    enable = true,
  },
  playground = {
    enable = {},
    disable = { 'thrift' },
    updatetime = 25,
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
})

-- 开启 Folding 模块
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.opt.foldlevel = 99

vim.api.nvim_create_augroup('cmdwin_treesitter', { clear = true })
vim.api.nvim_create_autocmd('CmdwinEnter', {
  pattern = '*',
  command = 'TSBufDisable incremental_selection',
  group = 'cmdwin_treesitter',
  desc = "Disable treesitter's incremental selection in Command-line window",
})
