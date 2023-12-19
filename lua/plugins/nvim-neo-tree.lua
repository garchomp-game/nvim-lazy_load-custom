return {
  {
    "MunifTanjim/nui.nvim",
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    event = { 'CmdLineEnter', 'BufRead' },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim"
    },
    config = function()
      -- vim.api.nvim_set_keymap(
      --   'n','<C-n>',
      --   ':Neotree toggle<CR>',
      --   { noremap = true, silent = true }
      -- )
    end,
    opts = function()
      require("neo-tree").setup()
    end
  }
}
