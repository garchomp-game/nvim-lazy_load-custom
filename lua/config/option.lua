vim.cmd([[colorscheme base16-monokai]])
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
vim.opt.clipboard = "unnamedplus"


-- if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
--   vim.o.shell = 'powershell'
--   vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
--   vim.o.shellquote = '\"'
--   vim.o.shellxquote = ''
-- end
