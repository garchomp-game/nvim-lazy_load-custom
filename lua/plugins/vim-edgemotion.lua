return {
  'haya14busa/vim-edgemotion',
  event = { 'CmdLineEnter', 'BufRead' },
  config = function()
    vim.api.nvim_set_keymap('n', '<C-f>', '<Plug>(edgemotion-j)', {})
    vim.api.nvim_set_keymap('n', '<C-d>', '<Plug>(edgemotion-k)', {})
  end,
}
