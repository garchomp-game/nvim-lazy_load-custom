return {
  "folke/todo-comments.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    highlight = {
      before = "fg",
      keyword = "fg",
    }
  }
}
