---@diagnostic disable: undefined-global
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<A-.>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp', priority = 95 },
    { name = 'dummycoder', priority = 90 },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
})

-- 检查当前LSP服务器是否支持documentHighlight
local function setup_document_highlight()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  for _, client in ipairs(clients) do
    if client.supports_method('textDocument/documentHighlight') then
      vim.api.nvim_create_autocmd('CursorHold', {
        buffer = 0,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd('CursorMoved', {
        buffer = 0,
        callback = vim.lsp.buf.clear_references,
      })
      return
    end
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = setup_document_highlight,
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('switch_formatter', { clear = true }),
  pattern = 'lua',
  desc = 'switch formatter to stylua when filetype is lua',
  callback = function()
    vim.keymap.set('n', '<A-f>', ":lua require'stylua-nvim'.format_file()<CR>", { silent = true })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  -- group = vim.api.nvim_create_augroup('switch_runCommand', { clear = true }),
  pattern = 'scheme',
  desc = 'switch runCommand to racket when filetype is scheme like',
  callback = function()
    vim.keymap.set('n', '<leader>r', [[:!racket %<CR>]], reopt)
    vim.keymap.set('n', '<leader><A-f>', [[:!raco fmt --width 60 % > _temp__.rkt && mv _temp__.rkt %]] .. '<CR>', reopt)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  -- group = vim.api.nvim_create_augroup('switch_runCommand', { clear = true }),
  pattern = 'racket',
  desc = 'switch runCommand to racket when filetype is scheme like',
  callback = function()
    vim.keymap.set('n', '<leader>r', [[:!racket %<CR>]], reopt)
    vim.keymap.set('n', '<leader><A-f>', [[:!raco fmt --width 60 % > _temp__.rkt && mv _temp__.rkt %]] .. '<CR>', reopt)
  end,
})

-- / 查找模式使用 buffer 源
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

-- : 命令行模式中使用 path 和 cmdline 源.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})

require('keybindings').mapNvimCmp()
