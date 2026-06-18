-- mason.lua: Mason による開発ツールの一元管理
-- LSP server一覧と共通設定は lua/config/lsp.lua で管理
-- フォーマッタ・リンターは mason-tool-installer で自動インストール

return {
	-- Mason 本体
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	-- Mason ↔ LSP 連携
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = function()
			return {
				ensure_installed = require("config.lsp").server_names(),
				-- mason-lspconfig v2 ではインストール済みserverを vim.lsp.enable() で有効化する。
				automatic_enable = true,
			}
		end,
		config = function(_, opts)
			require("config.lsp").setup()
			require("mason-lspconfig").setup(opts)
		end,
	},

	-- フォーマッタ・リンターの自動インストール
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			ensure_installed = {
				-- フォーマッタ
				"stylua", -- Lua (conform.nvim)
				"biome", -- JS/TS/JSON (conform.nvim + nvim-lint)
				"prettier", -- CSS/HTML/YAML/MD/Vue/PHP (conform.nvim)
				-- デバッグアダプター
				"js-debug-adapter",     -- JS/TS (Node + Chrome)
				"php-debug-adapter",    -- PHP (Xdebug)
				"java-debug-adapter",   -- Java
				"java-test",            -- Java テスト
			},
			auto_update = false,
			run_on_start = true,
		},
	},
}
