-- mason.lua: Mason による開発ツールの一元管理
-- LSP設定は ~/.config/nvim/lsp/ + vim.lsp.config で管理
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

	-- Mason ↔ LSP 連携（ensure_installed のみ使用）
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"cssls",
				"bashls",
				"emmet_ls",
				"intelephense",
				"jsonls",
				"jdtls",
			},
			-- LSPの自動セットアップは使わない（vim.lsp.config で管理）
			automatic_installation = false,
		},
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
