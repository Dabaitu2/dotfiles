local Job = require('plenary.job')
local PopUp = require('local-plugins.popup')

-- 定义生成二维码并显示的函数
local function show_qr_code(target)
  -- 使用 plenary 的 Job API 来运行 qrencode 命令
  local job = Job:new({
    command = 'qrencode',
    args = { '-t', 'utf8', target },
    on_exit = function(job, exit_code)
      if exit_code ~= 0 then
        error('Error generating QR Code: ' .. error)
      else
        -- 打开新的 split 窗口，并设置其 buffer 为不可编辑和不列入 buffer 列表

        vim.schedule(function()
          -- local bufnr = vim.api.nvim_get_current_buf()
          -- vim.cmd('vnew | setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile')

          -- 获取当前窗口的 buffer 号
          -- 将二维码数据写入到 buffer 中

          local result = job:result()
          table.insert(result, '🤓🤓🤓请使用飞书扫码完成登陆🤓🤓🤓')
          -- vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, job:result())
          PopUp.show_popup(result)
        end)
      end
    end,
    on_stderr = function(error)
      if error then
        print('Error generating QR Code: ', error)
      end
    end,
  })

  -- 开始执行 job，并等待它完成（可异步执行以避免阻塞）
  job:start()
end

-- 向 Neovim 注册该函数为全局命令，便于调用
-- :ShowQRCode <url>
vim.api.nvim_create_user_command('ShowQRCode', function(input)
  show_qr_code(input.args)
end, { nargs = '*' })

-- 可以直接调用该函数或者使用命令行命令 :ShowQRCode <url>
