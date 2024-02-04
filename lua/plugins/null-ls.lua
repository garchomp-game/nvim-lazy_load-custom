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
        null_ls.builtins.formatting.stylua,
      },
    })
    vim.api.nvim_set_keymap(
      "n",
      "<leader>f",
      "<cmd>lua vim.lsp.buf.formatting()<CR>",
      { noremap = true, silent = true }
    )
  end,
}
