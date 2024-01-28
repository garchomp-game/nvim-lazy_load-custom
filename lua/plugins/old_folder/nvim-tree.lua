return {
  'kyazdani42/nvim-tree.lua',
  event = { 'BufRead' },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {'<C-n>'},
  config = function()
    vim.api.nvim_set_keymap(
      'n','<C-n>',
      ':NvimTreeToggle<CR>',
      { noremap = true, silent = true }
    )
  end
}
