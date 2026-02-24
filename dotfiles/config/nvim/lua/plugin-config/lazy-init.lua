local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'yetone/avante.nvim',
    -- 如果您想从源代码构建，请执行 `make BUILD_FROM_SOURCE=true`
    -- ⚠️ 一定要加上这一行配置！！！！！
    build = 'make',
    event = 'VeryLazy',
    version = false, -- 永远不要将此值设置为 "*"！永远不要！
    keys = {
      {
        '<leader>ad',
        function()
          local tree_ext = require('avante.extensions.nvim_tree')
          tree_ext.add_file()
        end,
      },
    },
    ---@module 'avante'
    ---@diagnostic disable-next-line: undefined-doc-name
    ---@type avante.Config
    opts = {
      -- 在此处添加任何选项
      -- 例如
      provider = 'openai',
      providers = {
        openai = {
          endpoint = 'https://ark-cn-beijing.bytedance.net/api/v3',
          model = 'ep-20251119113407-jwxnm',
          -- endpoint = 'https://ai-yyds.com/v1',
          -- model = 'claude-sonnet-4-20250514',
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 20000,
            thinking = {
              type = 'disabled',
            },
          },
        },
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- 以下依赖项是可选的，
      'echasnovski/mini.pick', -- 用于文件选择器提供者 mini.pick
      'nvim-telescope/telescope.nvim', -- 用于文件选择器提供者 telescope
      'hrsh7th/nvim-cmp', -- avante 命令和提及的自动完成
      'ibhagwan/fzf-lua', -- 用于文件选择器提供者 fzf
      'nvim-tree/nvim-web-devicons', -- 或 echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- 用于 providers='copilot'
      {
        -- 支持图像粘贴
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- 推荐设置
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- Windows 用户必需
            use_absolute_path = true,
          },
        },
      },
      {
        -- 如果您有 lazy=true，请确保正确设置
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
  -- {
  --   'https://code.byted.org/zhanghaoyang.tomoko/dummy-coder.nvim',
  --   branch = 'feat-oauth2',
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --   },
  --   config = function()
  --     require('dummy-coder').setup({
  --       log = {
  --         auto_clear = true,
  --         -- min_level = 'TRACE',
  --       },
  --       plugins = {
  --         code_gen = {
  --           nvim_cmp = true,
  --           -- virt_text = false,
  --           max_context_range = 30,
  --           filetype_to_language = {
  --             haskell = 'haskell',
  --             thrift = 'thrift',
  --           },
  --         },
  --       },
  --       mappings = {
  --         DummyCoderAccept = {
  --           i = '<C-]>',
  --           n = '<C-]>',
  --         },
  --       },
  --     })
  --   end,
  -- },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('plugin-config.devicons')
      require('plugin-config.nvim-tree-conf')
    end,
  },
  { 'folke/tokyonight.nvim', branch = 'main' },
  'catppuccin/nvim',
  'solarnz/thrift.vim',
  'tikhomirov/vim-glsl',
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', 'moll/vim-bbye' },
    config = function()
      require('plugin-config.bufferline')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    after = 'nvim-tree.lua',
    dependencies = { 'kyazdani42/nvim-web-devicons', 'nvim-tree/nvim-tree.lua' },
    config = function()
      require('plugin-config.lualine')
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('plugin-config.telescope')
    end,
  },
  'nvim-telescope/telescope-symbols.nvim',
  'LinArcX/telescope-env.nvim',
  'glepnir/dashboard-nvim',
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('plugin-config.project')
    end,
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('plugin-config.comment')
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugin-config.gitsigns')
    end,
  },
  {
    'tpope/vim-surround',
    event = 'VeryLazy',
  },
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('plugin-config.toggleterm')
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('plugin-config.nvim-colorizer')
    end,
  },
  {
    'm-demare/hlargs.nvim',
    config = function()
      require('plugin-config.hlargs')
    end,
  },
  -- nvim-cmp
  {
    'neovim/nvim-lspconfig', -- LSP
    'hrsh7th/nvim-cmp', -- Completion engine
    'hrsh7th/cmp-nvim-lsp', -- LSP source
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'L3MON4D3/LuaSnip', -- Snippet engine
    'saadparwaiz1/cmp_luasnip', -- LuaSnip source
  },
  -- lspsaga，增强LSP UI
  { 'glepnir/lspsaga.nvim', branch = 'main', event = 'BufReadPre' },
  -- formatter
  {
    'stevearc/conform.nvim',
    opts = {
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true, -- 如果没有 formatter，会 fallback 到 LSP 的 format()
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'black' },
        javascript = { 'prettier' },
        go = { 'gofmt' },
        rust = { 'rustfmt' },
      },
    },
  },
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = true,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      local mlsp = require('mason-lspconfig')
      mlsp.setup({
        ensure_installed = { 'lua_ls', 'ts_ls', 'pyright', 'rust_analyzer', 'thriftls' },
        automatic_installation = true,
      })
    end,
  },
  -- { 'neoclide/coc.nvim', branch = 'release' },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('plugin-config.nvim-treesitter')
    end,
  },
  'nvim-treesitter/playground',
  'ckipp01/stylua-nvim',
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('plugin-config.autotag')
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('plugin-config.indent-blankline')
    end,
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', config = function() end },
  'b0o/schemastore.nvim',
  { 'jose-elias-alvarez/nvim-lsp-ts-utils', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'mfussenegger/nvim-dap', dependencies = { 'nvim-neotest/nvim-nio' } },
  'leoluz/nvim-dap-go',
  'rafamadriz/friendly-snippets',
  'theHamsta/nvim-dap-virtual-text',
  'rcarriga/nvim-dap-ui',
  {
    'windwp/nvim-autopairs',
    config = function()
      require('plugin-config.nvim-autopairs')
    end,
  },
  {
    'phaazon/hop.nvim',
    branch = 'v1', -- optional but strongly recommended
    config = function()
      require('plugin-config.hop')
    end,
  },
  {
    'lewis6991/impatient.nvim',
    config = function()
      require('plugin-config.impatient')
    end,
  },
  'tpope/vim-fugitive',
  {
    'folke/zen-mode.nvim',
    config = function()
      require('plugin-config.zen-mode')
    end,
  },
  {
    'benstockil/twilight.nvim',
    -- config = function()
    --   require('twilight').setup({
    --     alpha = 0.25,
    --   })
    -- end,
  },
  {
    'folke/which-key.nvim',
    config = function()
      require('plugin-config.which-key')
    end,
  },
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('todo-comments').setup()
    end,
  },
  {
    'folke/neodev.nvim',
  },
  {
    'junegunn/vim-easy-align',
    config = function()
      require('plugin-config.vim-easy-align')
    end,
  },
  {
    'chentoast/marks.nvim',
    config = function()
      require('marks').setup({
        -- whether to map keybinds or not. default true
        default_mappings = true,
        -- which builtin marks to show. default {}
        builtin_marks = { '.', '<', '>', '^' },
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher values will have better performance but may cause visual lag,
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- disables mark tracking for specific buftypes. default {}
        excluded_buftypes = {},
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = '⚑',
          virt_text = 'hello world',
          -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
          -- defaults to false.
          annotate = false,
        },
        mappings = {},
      })
    end,
  },
})
