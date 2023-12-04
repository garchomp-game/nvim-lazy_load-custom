return {
  "dense-analysis/ale",
  event = { 'CmdLineEnter', 'BufRead' },
  config = function()
    vim.g.ale_linters = {
      javascript = {'eslint'},
      -- 他の言語のリンター設定もここに追加
    }

    vim.g.ale_fixers = {
      ['*'] = {'remove_trailing_lines', 'trim_whitespace'},
      python = {'autopep8'},
      javascript = {'eslint'},
      -- 他の言語のフォーマッター設定もここに追加
    }

    vim.g.ale_lint_on_enter = 1  -- ファイルを開いたときにリントを実行
  end,
}
