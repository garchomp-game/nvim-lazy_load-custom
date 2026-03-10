-- conform.nvim: フォーマッタ専用プラグイン
-- none-ls（旧null-ls）からフォーマッタ機能を分離
return {
  'stevearc/conform.nvim',
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      '=',
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { 'n', 'v' },
      desc = "フォーマット",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "biome", "prettier", stop_after_first = true },
      typescript = { "biome", "prettier", stop_after_first = true },
      javascriptreact = { "biome", "prettier", stop_after_first = true },
      typescriptreact = { "biome", "prettier", stop_after_first = true },
      vue = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      html = { "prettier" },
      json = { "biome", "prettier", stop_after_first = true },
      jsonc = { "biome", "prettier", stop_after_first = true },
      yaml = { "prettier" },
      markdown = { "prettier" },
      php = { "prettier" },
      java = {},  -- jdtlsのLSPフォーマットを使用
    },
    -- デフォルトのフォーマットオプション
    default_format_opts = {
      lsp_format = "fallback",  -- フォーマッタがない場合はLSPフォールバック
    },
  },
}
