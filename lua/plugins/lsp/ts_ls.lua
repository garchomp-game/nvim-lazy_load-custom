-- plugins/lsp/ts_ls.lua

local M = {}

function M.custom_server_opts(server_opts, mason_registry)
  -- Vue Language Serverのパスを設定
  local vue_language_server = mason_registry.get_package('vue-language-server')
  local vue_language_server_path = vue_language_server:get_install_path() .. '/node_modules/@vue/language-server'

  -- Vueの初期化オプションを設定
  server_opts.init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vue_language_server_path,
        languages = { 'vue' },
      },
    },
  }

  -- ファイルタイプを設定
  server_opts.filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }

  -- コマンドの設定（必要に応じて）
  server_opts.cmd = { "typescript-language-server", "--stdio" }

  -- root_dirの設定（プロジェクトのルートを特定）
  server_opts.root_dir = require('lspconfig.util').root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")

  -- 追加の設定があればここに記述
  server_opts.settings = {
    typescript = {
      format = {
        enable = true,
        -- 追加のフォーマット設定があればここに記述
      },
    },
    javascript = {
      format = {
        enable = true,
        -- 追加のフォーマット設定があればここに記述
      },
    },
  }

  return server_opts
end

return M
