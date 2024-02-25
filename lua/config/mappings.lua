vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.api.nvim_set_keymap("n", "<A-s>", ":mksession! mysession.vim<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>vt", function()
	require("utils").VertTerm()
end, { noremap = true, silent = true })
