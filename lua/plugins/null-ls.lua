return {
  'nvimtools/none-ls.nvim',
  event = "VeryLazy",
  dependencies = {
    'williamboman/mason-lspconfig.nvim'
  },
  config = function()
    local null_ls = require("null-ls")
    -- `null-ls`のセットアップ
    null_ls.setup({
      sources = {
      },
    })
  end,
}
