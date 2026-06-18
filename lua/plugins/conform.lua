-- conform.nvim: フォーマッタ専用プラグイン
return {
  'stevearc/conform.nvim',
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      '<leader>f',
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = { 'n', 'v' },
      desc = "フォーマット",
    },
    {
      '<leader>cf',
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
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
