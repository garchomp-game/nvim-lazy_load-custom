return {
  'nvimtools/none-ls.nvim',
  event = "VeryLazy",
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'williamboman/mason.nvim',
  },
  config = function()
    -- ツールがインストールされているかどうかをチェックする関数
    local function tool_exists(name)
      return vim.fn.executable(name) > 0
    end

    -- none-lsの設定
    local null_ls = require("null-ls")

    -- 利用可能なフォーマッターとリンターの設定
    local sources = {}

    -- prettierがインストールされている場合に追加
    if tool_exists("prettier") then
      table.insert(sources, null_ls.builtins.formatting.prettier)
    end

    -- eslintがインストールされている場合に追加
    if tool_exists("eslint") then
      table.insert(sources, null_ls.builtins.diagnostics.eslint)
    end
    -- none-lsにソースを登録
    null_ls.setup({
      sources = sources,
    })
  end,
}
