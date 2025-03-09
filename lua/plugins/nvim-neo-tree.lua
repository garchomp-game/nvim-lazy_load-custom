return {
  'nvim-neo-tree/neo-tree.nvim',
  event = "VeryLazy",
  -- keys = {'<C-n>'},
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function(_, opts)
    vim.keymap.set(
      'n','<C-n>',
      ':Neotree toggle<CR>',
      { noremap = true, silent = true }
    )
    require("neo-tree").setup(opts)
  end,
  opts = {
    window = {
      width = 25,
      auto_expand_width = true,
    }
  }
}
