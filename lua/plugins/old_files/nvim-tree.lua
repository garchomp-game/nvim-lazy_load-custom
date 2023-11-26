return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  event = { 'CmdLineEnter', 'BufRead' },
  lazy = false,
  opts = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true

    -- OR setup with some options
    require("nvim-tree").setup {
      git = {
        ignore = false, -- .gitignoreされたファイルもtreeに表示する
      },
      -- 以下、treeのrootに関する設定
      -- prefer_startup_root = true,
      update_focused_file = {
        enable = false,          -- カレントバッファに合わせて常に更新
        update_root = true,      -- `:NvimTreeFindFile`すると更新
        ignore_list = {},
      },
      view = {
        -- sizeを動的に調整する
        width = {
          min = 5,
          max = 75,
          padding = 1
        }
      },
    }
  end,
}
