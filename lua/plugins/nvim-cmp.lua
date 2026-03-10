-- blink.cmp: 高速な補完エンジン（Rust製）
-- nvim-cmp + 11個のソースプラグインを1つに統合
return {
  'saghen/blink.cmp',
  event = "VeryLazy",
  dependencies = {
    'rafamadriz/friendly-snippets',  -- スニペット集
  },
  version = '1.*',  -- プリビルドバイナリを使用

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- キーマップ設定
    -- 'enter': Enterで確定（旧nvim-cmpのCR確定に近い動作）
    -- C-space: メニューを開く / C-n/C-p: 次/前の項目 / C-e: メニューを閉じる
    keymap = { preset = 'enter' },

    appearance = {
      nerd_font_variant = 'mono',  -- Nerd Font Monoを使用
    },

    -- 補完メニューの設定
    completion = {
      -- ドキュメントポップアップを自動表示
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 300,
      },
      -- ゴーストテキスト（補完候補のプレビュー）
      ghost_text = { enabled = true },
      -- nvim-cmp スタイルのメニュー表示
      menu = {
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind" },
          },
        },
      },
      -- 選択動作: 自動選択 + 自動挿入
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
    },

    -- 補完ソース（LSP、パス、スニペット、バッファの4つが組み込み）
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- Rust製のfuzzyマッチャー（タイプミスにも強い）
    fuzzy = { implementation = "prefer_rust_with_warning" },

    -- 署名ヘルプ（関数の引数情報）
    signature = { enabled = true },
  },
  opts_extend = { "sources.default" },
}
