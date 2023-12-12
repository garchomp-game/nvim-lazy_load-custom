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
      })
    end
  }
}
