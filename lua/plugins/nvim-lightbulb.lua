-- lua/plugins/nvim-lightbulb.lua

return {
  'kosayoda/nvim-lightbulb',
  event = "BufRead",
  dependencies = {
    'antoinemadec/FixCursorHold.nvim'
  },
  opts = {
    autocmd = { enabled = true }, -- 自動コマンドの有効化
    sign = {
      enabled = false, -- サイン（Vimのサインカラム）を無効化
    },
    status_text = {
      enabled = true, -- ステータスラインにテキストを表示
      text = ' ', -- 表示するテキスト（デフォルト: ' '）
      text_unavailable = ' ', -- コードアクションが利用できない場合のテキスト
    },
    virtual_text = {
      enabled = false, -- バーチャルテキストを無効化
    },
    float = {
      enabled = false, -- フロートウィンドウを無効化
    },
    keep_zero = false, -- コードアクションがない場合でもアイコンを表示しない
    ignore = {}, -- 特定のバッファタイプやファイルタイプを無視
  },
}
