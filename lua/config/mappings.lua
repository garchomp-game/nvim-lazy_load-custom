
vim.api.nvim_set_keymap(
'i',
'<C-h>',
'<Left>', { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
'i',
'<C-j>',
'<Down>', { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
'i',
'<C-k>',
'<Up>', { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
'i',
'<C-l>',
'<Right>', { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
'n',
'<C-h>',
'<C-w>h', { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
'n',
'<C-j>',
'<C-w>j', { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
'n',
'<C-k>',
'<C-w>k', { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
'n',
'<C-l>',
'<C-w>l', { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
'n',
'<A-s>',
':mksession! mysession.vim<CR>', { noremap = true, silent = true }
)
