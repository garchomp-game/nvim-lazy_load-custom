local utils = require("utils")
local data = vim.fn.stdpath("data")
local lazypath = data .. "/lazy/lazy.nvim"
local configs = {
  defaults = { lazy = true },
  dev = {
    path = "~/.config/nvim/pack"
  }
}

local home = vim.env.HOME
local lombok = data .. "/mason/packages/jdtls/lombok.jar"

if vim.fn.filereadable(home .. lombok) then
  vim.env.JDTLS_JVM_ARGS="-javaagent:"
  .. home
  .. lombok
end

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
