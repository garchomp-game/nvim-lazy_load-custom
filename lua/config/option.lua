local utils = require('utils')

vim.opt.helplang='ja,en'
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.mouse = ""
vim.opt.relativenumber = false
vim.opt.number = true
vim.opt.cursorcolumn = false
vim.opt.showcmd = true
vim.opt.ruler = true
vim.opt.ignorecase = true
vim.opt.foldenable = false
vim.opt.termguicolors = true

utils.onVimEnter(function()
  vim.opt.clipboard = "unnamedplus"
end)
