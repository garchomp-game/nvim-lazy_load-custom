return {
  {
    "MunifTanjim/nui.nvim",
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim"
    },
    event = { 'CmdLineEnter', 'BufRead' },
    opts = function()
      require("neo-tree").setup({
        -- その他の設定...
        filesystem = {

          components = {
            size = false
          },
        },
        window = {
          auto_expand_width = true, -- ウィンドウ幅を自動的に拡張する
          -- その他のウィンドウ関連の設定...
        },
        -- その他の設定...
      })
    end
  }
}
