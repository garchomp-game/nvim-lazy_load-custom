return {
  {
    'RRethy/nvim-base16',
  },
  -- プラグイン開発をサポートするdevtool系
  -- {
  --   'folke/neodev.nvim',
  --   event = { 'CmdLineEnter', 'BufRead' },
  -- }, 
  {
    'preservim/nerdtree',
    dependencies = {
      'ryanoasis/vim-devicons'
    },
    event = { 'CmdLineEnter', 'BufRead' },
  }, 
  {
    'junegunn/fzf',
    lazy = false,
    build = function()
      vim.fn["fzf#install"]()
    end,
  },
  {
    'junegunn/fzf.vim',
    lazy = false,
    dependencies = {
      'junegunn/fzf'
    },
  },
  {
    'dstein64/vim-startuptime',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'tpope/vim-commentary',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'vim-jp/vimdoc-ja',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'godlygeek/tabular',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'unblevable/quick-scope',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'skanehira/translate.vim',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'ryanoasis/vim-devicons',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'MunifTanjim/prettier.nvim',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'preservim/tagbar',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'hrsh7th/cmp-buffer',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'hrsh7th/cmp-path',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'hrsh7th/cmp-cmdline',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'hrsh7th/nvim-cmp',
    event = { 'CmdLineEnter', 'BufRead' },
    config = function()
      require 'plugins.config.nvim-cmp'
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  -- {
  --   'saadparwaiz1/cmp_luasnip',
  --   event = { 'CmdLineEnter', 'BufRead' },
  -- },
  {
    'nvim-lua/plenary.nvim',
    event = { 'CmdLineEnter', 'BufRead' },
    dependencies = {
      'dcampos/cmp-snippy',
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    event = { 'CmdLineEnter', 'BufRead' },
    config = function()
      require 'plugins.config.telescope'
    end,
  },
  {
    'williamboman/mason.nvim',
    event = { 'CmdLineEnter', 'BufRead' },
    config = function()
      require('plugins.config.mason')
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'CmdLineEnter', 'BufRead' },
    dependencies = {
      'williamboman/mason.nvim',
      'hrsh7th/nvim-cmp'
    },
    config = function()
      require 'plugins.config.mason-lspconfig'
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'CmdLineEnter', 'BufRead' },
    config = function()
      require('plugins.config.nvim-treesitter')
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = { 'CmdLineEnter', 'BufRead' },
    config = function()
      require('nvim-autopairs').setup {}
    end
  },
  {
    'mattn/vim-maketable',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'nvim-lualine/lualine.nvim',
    event = { 'CmdLineEnter', 'BufRead' },
    config = function()
      require 'plugins.config.lualine'
    end,
  },
  {
    -- git config --global commit.verbose trueを設定する
    'lambdalisue/gina.vim',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'nvim-lua/plenary.nvim',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'phaazon/mind.nvim',
    event = { 'CmdLineEnter', 'BufRead' },
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require 'mind'.setup()
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'CmdLineEnter', 'BufRead' },
    config = function()
      require 'plugins.config.null-ls'
    end,
  }
}
