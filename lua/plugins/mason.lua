-- ユーティリティモジュールを読み込み
local utils = require('utils')

-- 初期セットアップが完了しているかをチェックし、イベントを設定
local load_event = utils.get_is_initial_setup_done() and 'VimEnter' or 'VeryLazy'

-- プラグイン設定を返す
return {
  {
    -- mason-lspconfigプラグインの設定
    'williamboman/mason-lspconfig.nvim',
    event = load_event, -- 設定されたイベントでプラグインを読み込む
    dependencies = {
      'williamboman/mason.nvim',  -- Masonの依存プラグイン
      'hrsh7th/nvim-cmp',          -- 自動補完プラグイン
      'folke/neodev.nvim'          -- Neovim開発用設定プラグイン
    },
    config = function()
      -- 診断メッセージのナビゲーションキーを設定
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true, silent = true }) -- 前の診断メッセージに移動
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true }) -- 次の診断メッセージに移動

      -- Termux環境かどうかを判定する関数
      local is_termux = utils.is_termux

      -- 言語サーバーのリストを定義
      local language_server_list = {
        "jdtls",
        "tsserver",
        "cssls",
        "volar",
        "bashls",
        "emmet_ls",
        "eslint",
        "intelephense",
        "kotlin_language_server",  -- Kotlin用のLSPを追加
      }

      -- Termuxでない場合、追加の言語サーバーをリストに含める
      if not is_termux() then
        table.insert(language_server_list, "lua_ls")
        table.insert(language_server_list, "phpactor")
        table.insert(language_server_list, "psalm")
      end

      -- mason-lspconfigの設定を行い、必要な言語サーバーをインストール
      require("mason-lspconfig").setup{
        ensure_installed = language_server_list, -- 必要な言語サーバーを指定
      }

      -- cmp用のLSP能力を取得
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Masonのレジストリを取得
      local mason_registry = require('mason-registry')

      -- 言語サーバーごとのカスタム設定を別ファイルから読み込む
      local server_settings = {
        lua_ls = require('plugins.lsp.lua_ls'),
        jdtls = require('plugins.lsp.jdtls'),
        tsserver = require('plugins.lsp.tsserver')
      }

      -- mason-lspconfig の setup_handlers を使用してサーバーを設定
      require("mason-lspconfig").setup_handlers {
        -- デフォルトのハンドラー
        function (server_name)
          local opts = {
            capabilities = capabilities,
          }

          -- カスタム設定が存在する場合は適用
          if server_settings[server_name] then
            if server_name == "lua_ls" and not is_termux() then
              opts = server_settings.lua_ls.custom_server_opts(opts)
            elseif server_name == "jdtls" then
              opts = server_settings.jdtls.option(opts)
            elseif server_name == "tsserver" then
              opts = server_settings.tsserver.custom_server_opts(opts, mason_registry)
            elseif server_name == "volar" then
              opts.filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
            end
          end

          -- opts がテーブルであることを確認
          if type(opts) ~= "table" then
            vim.notify("設定オプションがテーブルではありません: " .. server_name, vim.log.levels.ERROR)
            opts = {}
          end

          -- LSPサーバーをセットアップ
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
      local is_termux = utils.is_termux

      -- インストールすべきツールのリストを定義（重複を排除）
      local tool_list = {
        "bash-debug-adapter",
        "bash-language-server",
        "vim-language-server",
        "prettier",
        "json-lsp",
        "textlint",
        "eslint-lsp",
        "vue-language-server",
        "typescript-language-server",
        "intelephense",
        "jdtls",
        "phpactor",
        "psalm",
        "stylua",
        "markdownlint",
        "eslint_d",
        "kotlin-language-server",  -- Kotlin用のツールを追加
      }

      -- Termuxでない場合、追加のツールをリストに含める
      if not is_termux() then
        table.insert(tool_list, "lua-language-server")
      end

      -- インストールが必要なツールをチェックし、インストールする関数
      local function check_installation()
        local mr = require("mason-registry")
        mr.refresh(function ()
          for _, tool in ipairs(tool_list) do
            local pkg = mr.get_package(tool)
            if pkg and not pkg:is_installed() then
              pkg:install()
            end
          end
        end)
      end

      -- Masonの初期設定を行う
      require("mason").setup()

      -- 初期セットアップが完了している場合、Masonウィンドウを開く
      if utils.get_is_initial_setup_done() then
        vim.cmd("Mason")
      end

      -- ツールのインストールチェックを実行
      check_installation()
    end,
  },
}
