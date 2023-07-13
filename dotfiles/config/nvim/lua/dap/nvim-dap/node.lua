local dap = require('dap')

-- some adapters
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { vim.env.HOME .. '/.vscode/extensions/ms-vscode.node-debug2-1.43.0/out/src/nodeDebug.js' },
}
dap.configurations.javascript = {
  -- 启动一个空白的 debugger 服务器
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- attach 到已经启动的 debugger 服务器
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require('dap.utils').pick_process,
  },
}
