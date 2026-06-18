return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  cmd = {
    "BufferLineCycleNext",
    "BufferLineCyclePrev",
    "BufferLinePick",
    "BufferLineCloseOthers",
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "次のbufferへ" },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "前のbufferへ" },
    { "<leader>bn", "<cmd>BufferLineCycleNext<cr>", desc = "次のbufferへ" },
    { "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", desc = "前のbufferへ" },
    { "<leader>bf", "<cmd>BufferLinePick<cr>", desc = "bufferを選択" },
    { "<leader>bd", "<cmd>bdelete<cr>", desc = "現在のbufferを閉じる" },
    { "<leader>bD", "<cmd>BufferLineCloseOthers<cr>", desc = "他のbufferを閉じる" },
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      separator_style = "thin",
      offsets = {
        {
          filetype = "neo-tree",
          text = "Files",
          text_align = "center",
          separator = true,
        },
      },
    },
  },
}
