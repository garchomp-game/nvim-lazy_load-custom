return {
  'nvimtools/none-ls.nvim',  -- このプラグイン名は正しい
  event = "VeryLazy",
  dependencies = {
    'williamboman/mason.nvim',
    'nvim-lua/plenary.nvim',  -- 必須の依存関係を追加しておくとよい
  },
  config = function()
    local utils = require('utils')
    -- null-lsの設定（これは正しい - 変更しない）
    local null_ls = require("null-ls")  -- ここを none-ls から null-ls に戻す

    -- 以下は同じままで大丈夫
    local sources = {}

    if utils.tool_exists("prettier") then
      table.insert(sources, null_ls.builtins.formatting.prettier)
    end

    if utils.tool_exists("eslint") then
      table.insert(sources, null_ls.builtins.diagnostics.eslint)
      table.insert(sources, null_ls.builtins.formatting.eslint_d)
    end

    null_ls.setup({
      sources = sources,
    })
  end,
}
