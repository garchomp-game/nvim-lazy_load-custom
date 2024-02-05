-- netrwなどの不要な組み込みプラグインを無効化
vim.g.loaded_netrw        = 1
vim.g.loaded_netrwPlugin  = 1
vim.g.loaded_gzip         = 1
vim.g.loaded_zip          = 1
vim.g.loaded_zipPlugin    = 1
vim.g.loaded_tar          = 1
vim.g.loaded_tarPlugin    = 1
vim.g.loaded_getscript    = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball      = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_matchit      = 1
vim.g.loaded_matchparen   = 1
vim.g.loaded_logiPat      = 1
vim.g.loaded_rrhelper     = 1
vim.g.loaded_spellfile_plugin = 1
local utils = require("utils")
local data = vim.fn.stdpath("data")
local lazypath = data .. "/lazy/lazy.nvim"
local configs = {
  defaults = { lazy = true },
  dev = {
    path = "~/.config/nvim/pack"
  }
}

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  utils.set_is_initial_setup_done(true)
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", configs)
if utils.get_is_initial_setup_done() then
  vim.cmd("close")
end
require 'config'
