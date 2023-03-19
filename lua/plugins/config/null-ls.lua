local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.textlint.with({
      -- ルールセットは、ホームディレクトリにnode_modulesを
      -- 置いておく必要があるため、-gオプションを
      -- つけない。
      -- cd ~
      -- npm install textlint textlint-rule-prh textlint-rule-preset-jtf-style textlint-rule-preset-ja-technical-writing textlint-rule-terminology textlint-rule-preset-ja-spacing
      filetypes = { "text", "markdown" }
    }),
  },
})
