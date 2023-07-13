-- 基础设置
require('basic')
-- 键盘操作
require('keybindings')

-- Packer 插件管理
require('plugins')

-- Colorscheme
require('plugin-config.devicons')
require('colorscheme')

-- Plugins
require('plugin-config.nvim-colorizer')
require('plugin-config.impatient')
require('plugin-config.nvim-tree')
require('plugin-config.bufferline')
require('plugin-config.lualine')
require('plugin-config.telescope')
require('plugin-config.dashboard')
require('plugin-config.nvim-treesitter')
require('plugin-config.hlargs')
require('plugin-config.project')
require('plugin-config.indent-blankline')
require('plugin-config.nvim-autopairs')
require('plugin-config.comment')
require('plugin-config.gitsigns')
require('plugin-config.toggleterm')
require('plugin-config.hop')
require('plugin-config.zen-mode')
require('plugin-config.which-key')

-- LSP
-- require('lsp')
-- vim.lsp.set_log_level("debug")
require('coc')

-- DAP
require('dap.nvim-dap')

-- IME
-- require('im')
