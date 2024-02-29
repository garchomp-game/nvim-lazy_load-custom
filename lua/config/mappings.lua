local opts = { noremap = true, silent = true }

vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<leader>vt", function()
	require("utils").VertTerm()
end, opts)

-- Alt + s でセッションを保存
vim.keymap.set("n", "<A-s>", ":mksession! mysession.vim<CR>", opts)

-- キーマッピングの定義
vim.keymap.set('n', '<leader>lo', "<Cmd>lopen<CR>", opts)
vim.keymap.set('n', '<leader>lc', "<Cmd>lclose<CR>", opts)
vim.keymap.set('n', '<leader>co', "<Cmd>copen<CR>", opts)
vim.keymap.set('n', '<leader>cc', "<Cmd>cclose<CR>", opts)

vim.keymap.set('n', '<leader>cq', function()
  vim.diagnostic.setqflist()
end, opts)

vim.keymap.set('n', '<leader>cn', function()
  vim.diagnostic.goto_next()
end, opts)

vim.keymap.set('n', '<leader>cp', function()
  vim.diagnostic.goto_prev()
end, opts)
