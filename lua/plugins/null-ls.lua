return {
  'nvimtools/none-ls.nvim',  -- 修正: プラグイン名を正しく
  event = "VeryLazy",
  dependencies = {
    'williamboman/mason.nvim',  -- mason.nvim のみで十分
  },
  config = function()
    local utils = require('utils')
    -- null-lsの設定
    local null_ls = require("null-ls")

    -- 利用可能なフォーマッターとリンターの設定
    local sources = {}

    -- prettierがインストールされている場合に追加
    if utils.tool_exists("prettier") then
      table.insert(sources, null_ls.builtins.formatting.prettier)
    end

    -- eslintがインストールされている場合に追加
    if utils.tool_exists("eslint") then
      table.insert(sources, null_ls.builtins.diagnostics.eslint)  -- 診断用eslint
      table.insert(sources, null_ls.builtins.formatting.eslint_d) -- フォーマッターeslint_d
    end

    -- markdownlintがインストールされている場合に追加
    -- if utils.tool_exists("markdownlint") then
    --   table.insert(sources, null_ls.builtins.diagnostics.markdownlint)
    -- end

    -- null-lsにソースを登録
    null_ls.setup({
      sources = sources,
    })
  end,
}
