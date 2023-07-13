local status, zenMode = pcall(require, "zen-mode")
if not status then
  vim.notify('没有找到 zen-mode')
  return
end

zenMode.setup({
  window = { 
    height = 0.95,
    options = {
      list = false
    }
  },
  plugins = {
    twilight = {
      enable = true
    }
  }

})

require("keybindings").mapZenMode()

