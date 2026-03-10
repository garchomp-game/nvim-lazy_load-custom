-- mason.lua: Mason はインストーラとしてのみ使用
-- LSP設定は ~/.config/nvim/lsp/ + vim.lsp.config で管理

return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {},  -- デフォルト設定で初期化
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    dependencies = {
      'williamboman/mason.nvim',
    },
    opts = {
      -- Mason経由でインストールする LSP サーバー
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
      -- 自動セットアップは使わない（vim.lsp.config で管理）
      automatic_installation = true,
    },
  },
}
