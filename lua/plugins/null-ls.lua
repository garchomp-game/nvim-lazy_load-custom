return {
  'nvimtools/none-ls.nvim',
  event = "VeryLazy",
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'williamboman/mason.nvim',
  },
  config = function()
    local utils = require('utils')
    -- none-lsの設定
    local null_ls = require("null-ls")

    -- 利用可能なフォーマッターとリンターの設定
    local sources = {}

    -- prettierがインストールされている場合に追加
    if utils.tool_exists("prettier") then
      table.insert(sources, null_ls.builtins.formatting.prettier)
    end

    -- eslintがインストールされている場合に追加
    if utils.tool_exists("eslint") then
      table.insert(sources, null_ls.builtins.diagnostics.eslint)
    end

    -- markdownlintがインストールされている場合に追加
    if utils.tool_exists("markdownlint") then
      table.insert(sources, null_ls.builtins.diagnostics.markdownlint)
    end

    -- none-lsにソースを登録
    null_ls.setup({
      sources = sources,
    })
  end,
}
