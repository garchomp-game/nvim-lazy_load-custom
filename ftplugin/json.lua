-- JSON ファイルタイプ設定
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true
vim.opt_local.conceallevel = 0       -- JSONは記法を隠さない
vim.opt_local.formatoptions:remove('t')  -- 自動改行しない
