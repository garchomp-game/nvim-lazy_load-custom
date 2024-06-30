local utils = require('utils')

vim.opt.helplang='ja,en'
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.mouse = ""
vim.opt.relativenumber = false
if utils.is_termux() then
  vim.opt.number = false
else
  vim.opt.number = true
end
vim.opt.cursorcolumn = false
vim.opt.showcmd = true
vim.opt.ruler = true
vim.opt.ignorecase = true
vim.opt.foldenable = false
vim.opt.termguicolors = true
vim.g.markdown_recommended_style = 0
vim.g.neovide_cursor_animation_length = 0.13
vim.g.neovide_cursor_trail_length = 0.0
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_animate_window_resize = true
vim.g.neovide_background_color = "#282c34" .. string.format("%x", math.floor(255 * 0.8))
vim.g.neovide_refresh_rate = 144

utils.setup_very_lazy(function()
  vim.opt.clipboard = "unnamedplus"
end)

if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = "win32yank",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf"
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf"
    },
    cache_enable = 0,
  }
end
