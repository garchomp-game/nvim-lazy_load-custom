return {
  {
    "folke/which-key.nvim",
    event = { "CmdLineEnter", "BufRead" },
  }, 
  {
    "folke/neoconf.nvim",
    event = { "CmdLineEnter", "BufRead" },
  },
  {
    "folke/neodev.nvim",
  }, 
  {
    "preservim/nerdtree",
    event = { "CmdLineEnter", "BufRead" },
  }, 
  {
    'junegunn/fzf',
    event = { "CmdLineEnter", "BufRead" },
  },
  {
    'junegunn/fzf.vim',
    event = { "CmdLineEnter", "BufRead" },
  },
  {
    'dstein64/vim-startuptime',
    event = { "CmdLineEnter", "BufRead" },
  },
  {
    'tpope/vim-commentary',
    event = { "CmdLineEnter", "BufRead" },
  },
  {
    'vim-jp/vimdoc-ja',
    event = { "CmdLineEnter", "BufRead" },
  },
  {
    'godlygeek/tabular',
    event = { "CmdLineEnter", "BufRead" },
  },
  {
    'unblevable/quick-scope',
    event = { "CmdLineEnter", "BufRead" },
  },
  {
    'skanehira/translate.vim',
    event = { "CmdLineEnter", "BufRead" },
  },
  {
    'ryanoasis/vim-devicons',
    event = { "CmdLineEnter", "BufRead" },
  },
  {
    'MunifTanjim/prettier.nvim',
    event = { "CmdLineEnter", "BufRead" },
  },
  {
    'preservim/tagbar',
    event = { "CmdLineEnter", "BufRead" },
  },
  "neovim/nvim-lspconfig",
  "williamboman/mason-lspconfig.nvim",
  {
    'williamboman/mason.nvim',
    cmd = "Mason",
    dependencies = {
      "williamboman/mason-lspconfig.nvim"
    },
    config = function()
      require('plugins.config.mason')
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    event = { "CmdLineEnter", "BufRead" },
  },
}
