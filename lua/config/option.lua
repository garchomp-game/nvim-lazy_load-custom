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
-- markdownファイルのみタブ=スペース4個分になる現象をこれで解決できる
-- ソース: https://www.reddit.com/r/neovim/comments/z2lhyz/when_i_insert_tab_it_expands_to_4_spaces_and_not/?rdt=60892
vim.g.markdown_recommended_style = 0

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
