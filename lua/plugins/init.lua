return {
	{
		'RRethy/nvim-base16',
	},
	{
		'folke/neoconf.nvim',
		event = { 'CmdLineEnter', 'BufRead' },
	},
	{
		'folke/neodev.nvim',
		event = { 'CmdLineEnter', 'BufRead' },
	}, 
	{
		'preservim/nerdtree',
		event = { 'CmdLineEnter', 'BufRead' },
	}, 
	{
		'junegunn/fzf',
		event = { 'CmdLineEnter', 'BufRead' },
	},
	{
		'junegunn/fzf.vim',
		event = { 'CmdLineEnter', 'BufRead' },
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
		config = function()
			require 'plugins.config.nvim-lspconfig'
		end,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		event = { 'CmdLineEnter', 'BufRead' },
		dependencies = {
			'williamboman/mason.nvim'
		},
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
		'hrsh7th/cmp-vsnip',
		event = { 'CmdLineEnter', 'BufRead' },
	},
	{
		'hrsh7th/vim-vsnip',
		event = { 'CmdLineEnter', 'BufRead' },
	},
	{
		'L3MON4D3/LuaSnip',
		event = { 'CmdLineEnter', 'BufRead' },
	},
	{
		'saadparwaiz1/cmp_luasnip',
		event = { 'CmdLineEnter', 'BufRead' },
	},
	{
		'dcampos/nvim-snippy',
		event = { 'CmdLineEnter', 'BufRead' },
	},
	{
		'dcampos/cmp-snippy',
		event = { 'CmdLineEnter', 'BufRead' },
	},
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
		dependencies = {
			'williamboman/mason-lspconfig.nvim'
		},
		config = function()
			require('plugins.config.mason')
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
}
