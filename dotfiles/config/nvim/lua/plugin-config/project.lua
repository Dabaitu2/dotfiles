local status, project = pcall(require, 'project_nvim')
if not status then
  vim.notify('project_nvim is not found!')
  return
end

-- nvim-tree 支持
vim.g.nvim_tree_respect_buf_cwd = 1

project.setup({
  respect_buf_cwd = true,
  detection_methods = { 'pattern' },
  -- to make sure we have our special project, we use specific suffix to identify that, which is .tomoko
  patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', '.sln', '.tomoko', 'rush.json' },
  exclude_dirs = { '~' },
})

local status, telescope = pcall(require, 'telescope')
if not status then
  vim.notify('telescope is not found!')
  return
end
pcall(telescope.load_extension, 'projects')
