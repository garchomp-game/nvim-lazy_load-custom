require'fzf-lua'.setup({
  winopts = {
    height     = 0.85,     -- window height
    width      = 0.80,     -- window width
    row        = 0.35,     -- window row position (0=top, 1=bottom)
    col        = 0.50,     -- window col position (0=left, 1=right)
    border     = 'rounded' -- 'none', 'single', 'double', 'thicc' or 'rounded'
    fullscreen = false,    -- start fullscreen?
  },
})

vim.cmd [[
highlight FzfLuaNormal guibg=#383850
highlight FzfLuaBorder guibg=#383850
]]

vim.opt.winblend = 5
vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.keymap.set('n', '<C-e>', "<cmd>lua require('fzf-lua').files()<CR>")
