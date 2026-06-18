return {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = 'Neotree',
  keys = {
    { '<C-n>', '<cmd>Neotree toggle<cr>', desc = 'ファイルツリーを開閉' },
    { '<leader>e', '<cmd>Neotree toggle reveal<cr>', desc = 'ファイルツリーを開閉' },
    { '<leader>E', '<cmd>Neotree reveal<cr>', desc = '現在のファイルをツリーで表示' },
    { '<leader>o', '<cmd>Neotree focus<cr>', desc = 'ファイルツリーへ移動' },
    { '<leader>be', '<cmd>Neotree toggle show buffers right<cr>', desc = 'Bufferツリーを開閉' },
    { '<leader>ge', '<cmd>Neotree toggle git_status right<cr>', desc = 'Gitツリーを開閉' },
  },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
  end,
  opts = {
    window = {
      width = 25,
      auto_expand_width = false,
      mappings = {
        ["<space>"] = { function() end, nowait = false, desc = "leader prefix" },
        ["<leader>e"] = "close_window",
      },
    }
  }
}
