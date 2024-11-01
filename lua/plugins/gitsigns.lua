local utils = require('utils')

-- Gitsignsの設定をローカル変数に分割
local gitsigns_opts = {
  -- シンボルの定義
  signs               = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn          = true, -- `:Gitsigns toggle_signs` で切り替え可能
  numhl               = false, -- `:Gitsigns toggle_numhl` で切り替え可能
  linehl              = false, -- `:Gitsigns toggle_linehl` で切り替え可能
  word_diff           = false, -- `:Gitsigns toggle_word_diff` で切り替え可能
  attach_to_untracked = true,
  current_line_blame  = false, -- `:Gitsigns toggle_current_line_blame` で切り替え可能

  -- on_attach 関数: バッファがアタッチされたときに呼び出される
  on_attach           = function(bufnr)
    return vim.bo[bufnr].filetype ~= "markdown"
  end,
}

-- プラグイン設定の返却
return utils.setup_non_termux_config(function()
  return {
    'lewis6991/gitsigns.nvim',
    event = { 'BufRead', 'BufNewFile' },   -- BufRead と BufNewFile イベント時にプラグインを読み込む
    opts = gitsigns_opts,
  }
end)
