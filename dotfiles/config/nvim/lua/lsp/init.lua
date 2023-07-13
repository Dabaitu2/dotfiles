local lsp_installer = require('nvim-lsp-installer')

-- 安装列表
-- { key: 语言 value: 配置文件 }
-- key 必须为下列网址列出的名称
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps

-- server名: 配置 可以获得对应的配置文件内容
local servers = {
  -- lua/lsp/config/lua.lua
  sumneko_lua = require('lsp.config.lua'),
  tsserver = require('lsp.config.typescript'),
  -- rust_analyzer = require('lsp.config.rust'),
  bashls = require('lsp.config.bash'),
  pyright = require('lsp.config.pyright'),
  html = require('lsp.config.html'),
  cssls = require('lsp.config.css'),
  emmet_ls = require('lsp.config.emmet'),
  jsonls = require('lsp.config.json'),
  eslint = require('lsp.config.eslint'),
}

local on_attach = function(callback)
  local on_attach = function(client, bufnr)
    -- 禁用格式化功能，交给专门插件处理
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- 绑定快捷键
    require('keybindings').mapLSP(buf_set_keymap)
    -- 手动来 format
    -- vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()')
    pcall(callback, client, bufnr)
    vim.diagnostic.config({
      virtual_text = false,
    })
  end
  return on_attach
end

-- 启动 lsp server config
-- 启动何种 lsp 由 nvim 根据 file_type 自行决定
lsp_installer.setup({
  automatic_installation = true,
})
for lsp, config in pairs(servers) do
  if config == nil then
    return
  end

  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  require('lspconfig')[lsp].setup({
    capabilities = capabilities,
    on_attach = on_attach(config.opts.on_attach_callback),
    unpack(config.opts),
  })
end

-- Rust 有增强插件，单独配置
local rust_config = require('lsp.config.rust')
require('rust-tools').setup({
  server = {
    on_attach = on_attach(rust_config.opts.on_attach_callback),
    unpack(rust_config),
  },
  dap = rust_config.opts.dap,
})

-- emmet_ls 有 bug, 需要手动启动
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require('lspconfig').emmet_ls.setup({
  capabilities = capabilities,
  filetypes = { 'html', 'css', 'typescriptreact', 'javascriptreact', 'less', 'scss', 'sass' },
})

require('lsp.cmp')
require('lsp.ui')
require('lsp.null-ls')
