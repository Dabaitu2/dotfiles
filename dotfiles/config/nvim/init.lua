--
-- 基础设置
require('basic')
--
-- Packer 插件管理
-- require('plugins')
-- lazy 插件管理
require('plugin-config.lazy-init')
require('colorscheme')
--
-- 键盘操作
require('keybindings')
-- Colorscheme
require('plugin-config.devicons')

-- LSP
require('lsp')
-- vim.lsp.set_log_level("debug")
-- require('coc')

-- DAP
-- require('dap.nvim-dap')

-- IME
-- require('im')
--
--  TEST
require('local-plugins.count-paragraph-words').setup()
-- require('local-plugins.line-word-count').setup()
