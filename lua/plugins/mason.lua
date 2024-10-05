-- ユーティリティモジュールを読み込み
-- utilsモジュールは環境判定や初期設定の確認などを行うユーティリティ関数を提供
local utils = require('utils')

-- 初期セットアップが完了しているかをチェックし、イベントを設定
-- 初期セットアップが完了している場合は 'VimEnter'、それ以外は 'VeryLazy' を設定
-- 'VimEnter' はVimが完全にロードされた後に実行されるイベント
-- 'VeryLazy' は初期セットアップが未完了の場合に遅延読み込みするために使用
local load_event = utils.get_is_initial_setup_done() and 'VimEnter' or 'VeryLazy'

-- プラグイン設定を返す
-- Masonとmason-lspconfigを使ってLSP（Language Server Protocol）サーバーをセットアップするための設定を行う
return {
  {
    -- mason-lspconfigプラグインの設定
    'williamboman/mason-lspconfig.nvim',
    event = load_event, -- 設定されたイベントでプラグインを読み込む
    dependencies = {
      'williamboman/mason.nvim',  -- Masonの依存プラグイン。LSPサーバーやツールのインストールを管理するために使用
      'hrsh7th/nvim-cmp',          -- 自動補完プラグイン。LSPと連携してコード補完を提供
      'folke/neodev.nvim'          -- Neovim開発用設定プラグイン。Neovimの内部APIの補完とドキュメントを提供
    },
    config = function()
      -- 診断メッセージのナビゲーションキーを設定
      -- '[d' と ']d' で前後の診断メッセージに移動するショートカットを設定
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true, silent = true }) -- 前の診断メッセージに移動
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true }) -- 次の診断メッセージに移動

      -- Termux環境かどうかを判定する関数
      -- Termux環境では一部のLSPサーバーが動作しないため、特定の設定を適用しないように制御する
      local is_termux = utils.is_termux

      -- 言語サーバーのリストを定義
      -- 必要なLSPサーバーをリストとして定義し、これらのサーバーをインストールおよび設定する
      local language_server_list = {
        "jdtls",                  -- Java用のLSP
        "tsserver",               -- TypeScript用のLSP
        "cssls",                  -- CSS用のLSP
        "volar",                  -- Vue.js用のLSP
        "bashls",                 -- Bash用のLSP
        "emmet_ls",               -- HTML/CSSのEmmet補完用のLSP
        "eslint",                 -- JavaScript/TypeScriptのLinter用LSP
        "intelephense",           -- PHP用のLSP
        "kotlin_language_server", -- Kotlin用のLSPを追加
      }

      -- Termuxでない場合、追加の言語サーバーをリストに含める
      -- Termux環境で制約のあるサーバーを除外し、他の環境では追加のサーバーを設定する
      if not is_termux() then
        table.insert(language_server_list, "lua_ls")    -- Lua用のLSP
        table.insert(language_server_list, "phpactor")  -- PHP用の追加LSP
        table.insert(language_server_list, "psalm")     -- PHPの静的解析用LSP
      end

      -- mason-lspconfigの設定を行い、必要な言語サーバーをインストール
      require("mason-lspconfig").setup{
        ensure_installed = language_server_list, -- 必要な言語サーバーを指定
      }

      -- cmp用のLSP能力を取得
      -- nvim-cmpと連携するためのLSP機能を取得し、自動補完を提供
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Masonのレジストリを取得
      -- Masonによりインストールされたパッケージの管理情報を取得
      local mason_registry = require('mason-registry')

      -- 言語サーバーごとのカスタム設定を別ファイルから読み込む
      -- 各言語サーバーに応じたカスタマイズ設定を個別ファイルから取得し、必要に応じて適用する
      local server_settings = {
        lua_ls = require('plugins.lsp.lua_ls'),      -- Lua用の設定
        jdtls = require('plugins.lsp.jdtls'),        -- Java用の設定
        tsserver = require('plugins.lsp.tsserver')   -- TypeScript用の設定
      }

      -- mason-lspconfig の setup_handlers を使用してサーバーを設定
      -- 各LSPサーバーの設定を行い、必要に応じてカスタム設定を適用
      require("mason-lspconfig").setup_handlers {
        -- デフォルトのハンドラー
        function (server_name)
          local opts = {
            capabilities = capabilities, -- 自動補完機能と連携するための設定を追加
          }

          -- カスタム設定が存在する場合は適用
          if server_settings[server_name] then
            if server_name == "lua_ls" and not is_termux() then
              opts = server_settings.lua_ls.custom_server_opts(opts) -- Lua用のカスタム設定を適用
            elseif server_name == "jdtls" then
              opts = server_settings.jdtls.option(opts) -- Java用のカスタム設定を適用
            elseif server_name == "tsserver" then
              opts = server_settings.tsserver.custom_server_opts(opts, mason_registry) -- TypeScript用のカスタム設定を適用
            elseif server_name == "volar" then
              opts.filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' } -- Volarの対応ファイルタイプを設定
            end
          end

          -- opts がテーブルであることを確認
          -- 設定オプションが不正でないかをチェックし、エラーがあれば通知を表示
          if type(opts) ~= "table" then
            vim.notify("設定オプションがテーブルではありません: " .. server_name, vim.log.levels.ERROR)
            opts = {} -- デフォルトで空の設定にする
          end

          -- LSPサーバーをセットアップ
          -- エラーが発生した場合は通知を行い、問題の特定を容易にする
          local success, err = pcall(function()
            require("lspconfig")[server_name].setup(opts)
          end)
          if not success then
            vim.notify("LSPサーバーのセットアップに失敗しました: " .. server_name .. " エラー: " .. err, vim.log.levels.ERROR)
          end
        end,
      }
    end,
  },
  -- 残りのプラグイン設定は変更なし
  {
    -- masonプラグインの設定
    'williamboman/mason.nvim',
    event = load_event, -- 設定されたイベントでプラグインを読み込む
    config = function()
      -- Termux環境かどうかを判定する関数
      -- Termux環境で特定のツールがサポートされていない可能性があるため、環境判定を行う
      local is_termux = utils.is_termux

      -- インストールすべきツールのリストを定義（重複を排除）
      -- 各種LSPサーバーやデバッグツールなど、開発に必要なツールをリストとして定義
      local tool_list = {
        "bash-debug-adapter",           -- Bash用のデバッグアダプタ
        "bash-language-server",         -- Bash用のLSP
        "vim-language-server",          -- Vim用のLSP
        "prettier",                     -- コードフォーマッター
        "json-lsp",                     -- JSON用のLSP
        "textlint",                     -- テキストのLinter
        "eslint-lsp",                   -- ESLintのLSP
        "vue-language-server",          -- Vue.js用のLSP
        "typescript-language-server",   -- TypeScript用のLSP
        "intelephense",                 -- PHP用のLSP
        "jdtls",                        -- Java用のLSP
        "phpactor",                     -- PHP用のLSP
        "psalm",                        -- PHPの静的解析用ツール
        "stylua",                       -- Luaコードのフォーマッター
        "markdownlint",                 -- Markdown用のLinter
        "eslint_d",                     -- 高速なESLint
        "kotlin-language-server",       -- Kotlin用のツールを追加
      }

      -- Termuxでない場合、追加のツールをリストに含める
      -- Termux環境で利用できないツールがあるため、それを避ける
      if not is_termux() then
        table.insert(tool_list, "lua-language-server") -- Lua用のLSP
      end

      -- インストールが必要なツールをチェックし、インストールする関数
      -- mason-registryから必要なツールを取得し、インストールされていない場合はインストールを実行
      local function check_installation()
        local mr = require("mason-registry")
        mr.refresh(function ()
          for _,
