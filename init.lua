vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local plugins = require('plugins.init')
local configs = require('config.lazyConfigs')
require 'config'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugins, configs)


vim.cmd("colorscheme habamax")
vim.opt.helplang='ja,en'
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth =2
vim.opt.number = true
vim.opt.mouse = ""
vim.opt.cursorline = false
vim.opt.relativenumber = false
vim.opt.cursorcolumn = false
vim.opt.showcmd = true
vim.opt.ruler = true

