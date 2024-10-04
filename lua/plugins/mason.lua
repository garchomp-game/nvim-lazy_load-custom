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
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true, silent = true })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true })

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

      -- 各言語サーバーを設定
      for _, server in ipairs(language_server_list) do
        -- 基本オプションを設定
        local opts = {
          capabilities = capabilities,
        }

        -- 各言語サーバーに応じたカスタム設定を適用
        if server == "lua_ls" and not is_termux() then
          opts = server_settings.lua_ls.custom_server_opts(opts)
        elseif server == "jdtls" then
          server_settings.jdtls.option()
        elseif server == "tsserver" then
          opts = server_settings.tsserver.custom_server_opts(opts, mason_registry)
        elseif server == "volar" then
          -- Volar用のファイルタイプを設定
          opts.filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
        end

        -- LSPサーバーをセットアップ
        require("lspconfig")[server].setup(opts)
      end
    end,
  },
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
            if not pkg:is_installed() then
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
