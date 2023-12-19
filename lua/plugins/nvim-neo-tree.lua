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
    config = function()
      vim.api.nvim_set_keymap(
        'n','<C-n>',
        ':Neotree toggle<CR>',
        { noremap = true, silent = true }
      )
    end,
    opts = function()
      require("neo-tree").setup()
    end
  }
}
