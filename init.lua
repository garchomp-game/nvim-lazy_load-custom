vim.g.mapleader = " "
local utils = require("utils")
local data = vim.fn.stdpath("data")
local lazypath = data .. "/lazy/lazy.nvim"
local configs = {
  defaults = { lazy = true },
  dev = {
    path = vim.env.DEV_PLUGIN_PATH
  }
}

if not vim.uv.fs_stat(lazypath) then
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

-- Neovim 0.11+ 組み込みの vim.lsp.config を使ったLSP有効化
-- 各サーバーの設定は ~/.config/nvim/lsp/ に配置
vim.lsp.enable({
  'lua_ls',
  'ts_ls',
  'cssls',
  'bashls',
  'emmet_ls',
  'intelephense',
  'jsonls',
  'jdtls',
})
