-- plugins/lsp/jdtls.lua
local M = {}

function M.option(opts)
  local data = vim.fn.stdpath('data')
  local lombok = data .. "/mason/packages/jdtls/lombok.jar"

  if vim.fn.filereadable(lombok) then
    vim.env.JDTLS_JVM_ARGS = "-javaagent:" .. lombok
  end

  -- 必要なコマンドとルートディレクトリの設定
  opts.cmd = { "jdtls" }  -- 実際のコマンドに置き換えてください
  opts.root_dir = require('lspconfig').util.root_pattern("pom.xml", "build.gradle", "settings.gradle")

  -- 必要に応じて他の設定を追加

  return opts
end

return M
