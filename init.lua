local lazypath = vim.fn.stdpath("data")
      .. "/lazy/lazy.nvim"
local configs = {
  defaults = { lazy = true }
}

local home = vim.env.HOME
-- local lombok = "/.local/share/nvim/mason/packages/jdtls/lombok.jar"
-- local viminfo = "mysession.viminfo"

-- if vim.fn.filereadable(home .. lombok) then
--   vim.env.JDTLS_JVM_ARGS="-javaagent:"
--   .. home
--   .. lombok
-- end

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
require("lazy").setup("plugins", configs)
require 'config'
