return {
  'preservim/nerdtree',
  dependencies = {
    'ryanoasis/vim-devicons'
  },
  lazy = false,
  event = { 'VimEnter' },
  config = function()
    vim.api.nvim_set_keymap(
      'n','<C-n>',
      ':NERDTreeToggle<CR>',
      { noremap = true, silent = true }
    )
  end,
}
