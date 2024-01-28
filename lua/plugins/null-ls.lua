return {
  'nvimtools/none-ls.nvim',
  event = { 'CmdLineEnter', 'BufRead' },
  dependencies = {
    'williamboman/mason-lspconfig.nvim'
  },
  config = function()
    local null_ls = require("null-ls")
    -- `null-ls`のセットアップ
    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.markdownlint_cli2.with {
          args = { "$FILENAME" },
        },
      },
    })
  end,
}
