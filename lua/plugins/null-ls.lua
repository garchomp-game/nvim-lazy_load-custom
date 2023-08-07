return {
  'jose-elias-alvarez/null-ls.nvim',
  event = { 'CmdLineEnter', 'BufRead' },
  dependencies = {
    'williamboman/mason-lspconfig.nvim'
  },
  opts = function()

    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.markdownlint,
      },
    })
  end,
}
