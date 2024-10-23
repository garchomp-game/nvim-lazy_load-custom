return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,  -- プラグインを遅延読み込みしない設定
  dependencies = {
    'nvim-treesitter/playground',  -- Treesitter Playgroundを依存関係として追加
  },
  config = function()
    ---@class MyParserConfig
    ---@field blade table<string, any>
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

    -- Bladeテンプレートのカスタムパーサーを追加
    parser_config.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade", -- GitHubリポジトリURL
        files = {"src/parser.c"}, -- 必要なファイルリスト（パーサーのCソースファイル）
        branch = "main", -- 使用するブランチを指定
      },
      filetype = "blade", -- このパーサーが適用されるファイルタイプを指定
    }

    -- Treesitterの設定を行う
    require("nvim-treesitter.configs").setup {
      modules = {},  -- 必要なモジュールを追加
      -- Playgroundの設定
      playground = {
        enable = true,  -- Playground機能を有効にする
        disable = {},  -- 無効にするファイルタイプ（空の場合すべて有効）
        updatetime = 100, -- CPU使用率を下げるために更新間隔を増加
        persist_queries = false, -- クエリがVimセッション間で持続するかどうか（falseに設定）
        keybindings = {  -- Playgroundのキーバインドを設定
          toggle_query_editor = 'o',  -- クエリエディタの切り替え
          toggle_hl_groups = 'i',  -- ハイライトグループの切り替え
          toggle_injected_languages = 't',  -- インジェクトされた言語の表示切り替え
          toggle_anonymous_nodes = 'a',  -- 匿名ノードの表示切り替え
          toggle_language_display = 'I',  -- 言語の表示切り替え
          focus_language = 'f',  -- 特定の言語にフォーカス
          unfocus_language = 'F',  -- 言語のフォーカスを外す
          update = 'R',  -- Playgroundの更新
          goto_node = '<cr>',  -- ノードへのジャンプ
          show_help = '?',  -- ヘルプの表示
        },
      },
      -- インストールするパーサーのリストを指定
      ensure_installed = {
        "vim",  -- Vimスクリプト
        "vimdoc",  -- Vimのドキュメントファイル
        "java",  -- Javaプログラミング言語
        "php",  -- PHPプログラミング言語
        "vue",  -- Vue.jsフレームワーク
        "lua",  -- Luaプログラミング言語
        "javascript",  -- JavaScriptプログラミング言語
        "typescript",  -- TypeScriptプログラミング言語
        "markdown",  -- Markdownフォーマット
        "markdown_inline",  -- Markdownのインライン要素
        "blade",  -- Bladeテンプレート（Laravel）
        "html",  -- HTMLマークアップ言語
        "css",  -- CSSスタイルシート
        "scss",  -- SCSS（Sassの上位互換）
        "pug",  -- Pugテンプレートエンジン
        "bash",  -- Bashスクリプト
      },
      highlight = {
        enable = true, -- ハイライトを有効にしてコードの可読性を向上
        use_languagetree = true, -- LanguageTreeを使用してハイライトを実行する
        disable = function(_, buf)  -- 大きなファイルではハイライトを無効にする
          local max_filesize = 100 * 1024 -- 100 KB
          -- ファイルサイズをチェックし、特定のサイズ以上の場合はハイライトを無効にする
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      context_commentstring = {
        enable = true, -- コメントのコンテキストに基づいてハイライト
      },
      indent = {
        enable = true, -- インデントを自動で調整する機能を有効にする
      },
      sync_install = false,  -- 同期インストールを無効にする（必要に応じて有効化を検討）
      ignore_install = {},  -- 特定の言語のインストールを無視するリスト（ここでは空のまま）
      auto_install = true,  -- ファイルタイプに応じてパーサーを自動でインストールする機能を有効にする
    }
  end,
}
