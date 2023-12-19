return {
  {
    "MunifTanjim/nui.nvim",
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    event = { 'CmdLineEnter', 'BufRead' },
    keys = {'<C-n>'},
    config = function()
      vim.api.nvim_set_keymap(
        'n','<C-n>',
        ':Neotree toggle<CR>',
        { noremap = true, silent = true }
      )
    end,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim"
    },
    opts = function()
      require("neo-tree").setup()
    end
  }
}
