return {
  'RRethy/vim-illuminate',
  event = "VeryLazy",
  config = function()
    require('illuminate').configure({
      providers = {
        'regex',      -- デフォルトプロバイダー
        'lsp',        -- LSPを使用するプロバイダー
        'treesitter', -- Treesitterを使用するプロバイダー
      },
      delay = 100,    -- ハイライトの遅延時間（ミリ秒）
      filetypes_denylist = {
        'dirvish',
        'fugitive',
        'NvimTree',
      },
      filetypes_allowlist = {
        'lua',
        'python',
        'javascript',
        -- 必要に応じて追加
      },
      modes_denylist = {}, -- 特定のモードで無効にする
      providers_regex_syntax_denylist = {
        'Comment',
        'String',
      },
      providers_regex_syntax_allowlist = {},
      under_cursor = true, -- カーソル下の単語をハイライト
      large_file_cutoff = 2000, -- この行数を超えるファイルではハイライトを無効化
      large_file_overrides = {
        providers = false,
      },
      min_count_to_highlight = 1, -- ハイライトを行う最小出現回数
      -- strategy 設定を削除
    })
  end
}
