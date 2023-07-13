-- trying
function MyExecute(command)
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()
  return result
end

function Fcitx2en()
  local input_status = MyExecute('fcitx-remote')
  if tonumber(input_status) == 2 then
    vim.b.inputtoggle = 1
    MyExecute('fcitx-remote -c')
  else 
    vim.b.inputtoggle = 0
  end
end

function Fcitx2zh()
  local success, _ =  pcall(function ()
    if vim.b.inputtoggle == 1 then
      return MyExecute('fcitx-remote -o')
    end
  end)
  if not success then
   vim.b.inputtoggle = 0
 end
end

local imSwitch = vim.api.nvim_create_augroup("imSwitch", { clear = true })
vim.api.nvim_create_autocmd("InsertLeave", {
  command = "silent! lua Fcitx2en()",
  -- callback = Fcitx2en,
  group = imSwitch
})
vim.api.nvim_create_autocmd("BufEnter", {
  command = "silent! lua Fcitx2zh()",
  -- callback = Fcitx2zh,
  group = imSwitch
})

local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})
