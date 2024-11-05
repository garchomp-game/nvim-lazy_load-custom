local M = {}

function M.custom_server_opts(opts)
  local data = vim.fn.stdpath('data')
  local lombok = data .. "/mason/packages/jdtls/lombok.jar"

  if vim.fn.filereadable(lombok) then
    vim.env.JDTLS_JVM_ARGS = "-javaagent:" .. lombok
  end

  local home = vim.env.HOME
  local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

  -- フォーマット設定ファイルへのパス
  local eclipse_format = home .. '/.config/nvim/eclipse-java-google-style.xml' -- 必要に応じてパスを修正

  -- cmdの設定
  opts.cmd = {
    data .. '/mason/bin/jdtls', -- Masonでインストールされたjdtlsの実行パス
    '-data',
    home .. '/workspace/' .. workspace_dir,
  }

  -- lspconfig.utilを使用してroot_dirを設定
  local root_pattern = require('lspconfig.util').root_pattern
  opts.root_dir = root_pattern('.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle')(vim.fn.getcwd())

  -- フォーマット設定の追加
  opts.settings = {
    java = {
      format = {
        enabled = true,
        settings = {
          url = eclipse_format, -- フォーマット設定ファイルを指定
        },
      },
    },
  }

  -- 必要に応じてinit_optionsやその他の設定を追加
  opts.init_options = {
    bundles = {},
  }

  return opts
end

return M
