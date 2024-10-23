local M = {}

function M.custom_server_opts(server_opts, mason_registry)
  -- Vue Language Serverのパスを設定
  local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'

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
  return server_opts
end

return M
