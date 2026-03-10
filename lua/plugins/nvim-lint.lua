-- nvim-lint: リンター専用プラグイン
-- none-ls（旧null-ls）からリンター機能を分離
return {
  'mfussenegger/nvim-lint',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "biomejs" },
      typescript = { "biomejs" },
      javascriptreact = { "biomejs" },
      typescriptreact = { "biomejs" },
      json = { "biomejs" },
      jsonc = { "biomejs" },
    }

    -- ファイル保存時・読み込み時に自動でリントを実行
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = function()
        -- バッファが変更可能な場合のみリントを実行
        if vim.opt_local.modifiable:get() then
          lint.try_lint()
        end
      end,
    })
  end,
}
