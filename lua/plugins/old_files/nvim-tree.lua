return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  event = { 'CmdLineEnter', 'BufRead' },
  lazy = false,
  keys = {'<C-n>'},
  config = function()
    vim.api.nvim_set_keymap(
      'n','<C-n>',
      ':NvimTreeToggle<CR>',
      { noremap = true, silent = true }
    )
  end,
  opts = function()

    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true
    require("nvim-tree").setup {
      git = {
        enable = true,
      },
      -- renderer = {
      --   icons = {
      --     show = {
      --       git = false,  -- Gitアイコンを非表示にする
      --       file = false,  -- ファイルアイコンを非表示にする
      --       folder = false,  -- フォルダアイコンを非表示にする
      --       folder_arrow = false,  -- フォルダ矢印アイコンを非表示にする
      --     },
      --   },
      -- },
    }
  end,
}
