local status, nvim_dev_icon = pcall(require, 'nvim-web-devicons')
if not status then
  vim.notify('nvim-tree not found!')
  return
end

nvim_dev_icon.setup({
  strict = true,
  -- same as `override` but specifically for overrides by filename
  -- takes effect when `strict` is true
  override_by_filename = {
    ['.gitignore'] = {
      icon = '',
      color = '#f1502f',
      name = 'Gitignore',
    },
  },
  -- same as `override` but specifically for overrides by extension
  -- takes effect when `strict` is true
  override_by_extension = {
    ['log'] = {
      icon = '',
      color = '#81e043',
      name = 'Log',
    },
    ['txt'] = {
      icon = '',
      color = '#ffffff',
      name = 'Txt',
    },
    ['rkt'] = {
      icon = 'λ',
      color = '#9d10b0',
      name = 'Racket',
    },
    ['scm'] = {
      icon = 'λ',
      color = '#9d10b0',
      name = 'Racket',
    },
  },
})
