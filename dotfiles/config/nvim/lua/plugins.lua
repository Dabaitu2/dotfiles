local packer = require('packer')
packer.startup({
  function(use)
    -- packer 可以管理自己本身
    use('wbthomason/packer.nvim')
    --------- colorschemes ---------
    use({ 'folke/tokyonight.nvim', branch = 'main' })
    use('EdenEast/nightfox.nvim')
    use('catppuccin/nvim')
    use({ 'ellisonleao/gruvbox.nvim', requires = { 'rktjmp/lush.nvim' } })
    --------- other-plugin ---------
    use({ 'nvim-tree/nvim-tree.lua', requires = 'nvim-tree/nvim-web-devicons' })
    use('solarnz/thrift.vim')
    use('tikhomirov/vim-glsl')
    -- im 切换 --
    -- use('h-hg/fcitx.nvim')
    -- bbye 用于增加 Bdelete 命令关闭 buffer 但保持布局稳定
    use({ 'akinsho/bufferline.nvim', requires = { 'kyazdani42/nvim-web-devicons', 'moll/vim-bbye' } })
    use({ 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } })
    use('arkav/lualine-lsp-progress')
    use({ 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } })
    use({ 'nvim-telescope/telescope-symbols.nvim' })
    use('LinArcX/telescope-env.nvim')
    use('glepnir/dashboard-nvim')
    use('ahmedkhalf/project.nvim')
    use('numToStr/Comment.nvim')
    use('lewis6991/gitsigns.nvim')
    use('tpope/vim-surround')
    use('akinsho/toggleterm.nvim')
    -- 增加 hex 颜色提示
    use('norcalli/nvim-colorizer.lua')
    -- tree-sitter 用于增强代码高亮, 当 sync 完成时会自动调用 TsUpdate 更新相关的 language parser
    use({
      'm-demare/hlargs.nvim',
    })
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use({ 'nvim-treesitter/playground' })
    use({ 'p00f/nvim-ts-rainbow' })
    -- lua formatter, 因为 lua lsp 目前还没支持，需要手动使用 stylua
    use({ 'ckipp01/stylua-nvim' })
    -- 支持修改 tag pair
    use('windwp/nvim-ts-autotag')
    -- LSP 相关配置
    use('williamboman/nvim-lsp-installer')
    use('neovim/nvim-lspconfig')
    use('simrat39/rust-tools.nvim')
    use('mfussenegger/nvim-dap')
    use('leoluz/nvim-dap-go')
    -- 补全引擎
    use('hrsh7th/nvim-cmp')
    -- snippet 引擎
    use('hrsh7th/vim-vsnip')
    use('honza/vim-snippets')
    -- 补全源
    -- use('hrsh7th/cmp-vsnip')
    -- use('hrsh7th/cmp-nvim-lsp') -- { name = nvim_lsp }
    -- use('hrsh7th/cmp-buffer') -- { name = 'buffer' },
    -- use('hrsh7th/cmp-path') -- { name = 'path' }
    -- use('hrsh7th/cmp-cmdline') -- { name = 'cmdline' }
    -- 常见编程语言代码段
    use('rafamadriz/friendly-snippets')
    -- ui
    use('onsails/lspkind-nvim')
    -- indent-blankline
    use('lukas-reineke/indent-blankline.nvim')
    use('tami5/lspsaga.nvim')
    use({ 'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim' })
    use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
    -- json 增强
    use('b0o/schemastore.nvim')
    -- ts 增强
    use({ 'jose-elias-alvarez/nvim-lsp-ts-utils', requires = 'nvim-lua/plenary.nvim' })
    -- Debugging
    use('theHamsta/nvim-dap-virtual-text')
    use('rcarriga/nvim-dap-ui')
    use('windwp/nvim-autopairs')
    -- 任意跳转
    use({
      'phaazon/hop.nvim',
      branch = 'v1', -- optional but strongly recommended
    })
    -- 通过缓存来优化启动速度
    use('lewis6991/impatient.nvim')
    -- git
    use('tpope/vim-fugitive')
    -- zen mode
    use('folke/zen-mode.nvim')
    use({
      'benstockil/twilight.nvim',
      config = function()
        require('twilight').setup({
          alpha = 0.25,
        })
      end,
    })

    use({
      'chentoast/marks.nvim',
      config = function()
        require('marks').setup()
      end,
    })

    -- whichKey
    use({ 'folke/which-key.nvim' })
    use({ 'folke/trouble.nvim' })
    use({
      'folke/todo-comments.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('todo-comments').setup({
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        })
      end,
    })

    -- orgmode
    use({
      'nvim-orgmode/orgmode',
      config = function()
        require('orgmode').setup({
          org_agenda_files = { [[~/Library/Mobile Documents/com~apple~CloudDocs/org/*]], '~/learn-orgmode/**/*' },
          org_default_notes_file = [[~/Library/Mobile Documents/com~apple~CloudDocs/org/refile.org]],
          org_todo_keywords = {
            'TODO(t)',
            'POSTPONE(p)',
            'INPROGRESS',
            'DELAY(w)',
            '|',
            'DONE(d)',
            'CLOSED(c)',
          },
          org_todo_keyword_faces = {
            PENDING = ':foreground orange :weight bold',
            CLOSED = ':foreground gray :weight bold',
            DELAY = ':background #000000 :foreground red',
          },
          org_capture_templates = {
            r = {
              description = 'Repo',
              template = "* [[%x][%(return string.match('%x', '([^/]+)$'))]]%?",
              -- target = '~/learn-orgmode/repos.org',
              target = '~/Library/Mobile Documents/com~apple~CloudDocs/org/repos.org',
            },
            s = {
              description = 'Resource',
              template = '* [[%x][%?]]',
              target = '~/Library/Mobile Documents/com~apple~CloudDocs/org/resources.org',
            },
            n = {
              description = 'Quick Note',
              template = [[* %u%?]],
              target = '~/Library/Mobile Documents/com~apple~CloudDocs/org/quicknotes.org',
            },
          },
          mappings = {
            org = {
              org_toggle_checkbox = '<C-t>',
            },
          },
        })
      end,
    })

    -- coc
    use({ 'neoclide/coc.nvim', branch = 'release' })
    -- tablurazie comments or something
    use({
      'godlygeek/tabular',
    })

    -- chatGpt
    use({
      'jackMort/ChatGPT.nvim',
      config = function()
        require('chatgpt').setup({
          -- optional configuration
          openai_params = {
            max_tokens = 1000,
          },
        })
      end,
      requires = {
        'MunifTanjim/nui.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
      },
    })
  end,

  config = {
    max_jobs = 16,
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end,
    },
  },
})

--[[ 
  每次保存 plugins.lua 自动安装插件
  \[\[\]\] 包含的是 vim 脚本，因为目前 nvim 还不支持自动命令

  augroup = auto group 创建一个自动命令组, 后面指定的命令会一个一个自动执行
  autocmd! = 删除 packer_user_config 自动命令组的全部命令 (防止重名命令组命令的执行)
  autocmd 定义一个自动命令 , 这里的意思基本等同于在监听到 BufWritePost 的时候检查,
  如果是 plugins.lua, 就执行 PackerSync 自动更新插件
--]]
pcall(
  vim.cmd,
  [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
  ]]
)
