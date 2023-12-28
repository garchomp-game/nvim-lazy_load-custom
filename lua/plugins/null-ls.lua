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
        null_ls.builtins.formatting.prettier.with({
          -- Prettierを使用して多くの言語をフォーマット
          filetypes = {
            "javascript",
            "typescript",
            "css",
            "json",
            "yaml",
            "markdown",
            "vue",
            "html",
            "scss",
            "less",
            "graphql",
            "lua",
            "pug",
            "java",
            "kotlin"
          },

          -- 他のオプション
        }),
        null_ls.builtins.formatting.black.with({
          filetypes = { "python" }
        }),  -- Python用のフォーマッター
        null_ls.builtins.formatting.gofmt,  -- Go用のフォーマッター
        -- 他の言語用のフォーマッターをここに追加
      },
    })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {"javascript", "typescript", "css", "json", "yaml", "markdown", "vue", "html", "scss", "less", "graphql", "lua", "pug", "java", "kotlin"},
      callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
      end,
    })

  end,
}
