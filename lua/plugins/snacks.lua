-- snacks.nvim: Folke の統合ユーティリティ
-- nvim-notify, vim-illuminate, indent-blankline を統合
return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  ---@type snacks.Config
  opts = {
    -- 通知システム（nvim-notify の代替）
    notifier = { enabled = true },
    -- 大きなファイルの高速表示
    quickfile = { enabled = true },
    -- モダンなステータスカラム
    statuscolumn = { enabled = true },
    -- カーソル下の単語ハイライト（vim-illuminate の代替）
    words = { enabled = true },
    -- インデントガイド（indent-blankline の代替）
    indent = { enabled = true },
    -- 入力UIは dressing.nvim で管理（競合回避）
    input = { enabled = false },
  },
  keys = {
    { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = '次の参照', mode = { 'n', 't' } },
    { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = '前の参照', mode = { 'n', 't' } },
  },
}
