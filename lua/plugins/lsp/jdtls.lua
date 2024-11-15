-- plugins/lsp/jdtls.lua
local M = {}

function M.custom_server_opts(opts)
  local data_path = vim.fn.stdpath("data")
  local workspace_path = data_path .. "/jdtls-workspace/"
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  local lombok_path = data_path .. "/mason/packages/jdtls/lombok.jar"

  opts = {
    cmd = {
      'jdtls',
      '--jvm-arg=-javaagent:' .. lombok_path,        -- Lombokの設定
      '--jvm-arg=-Xbootclasspath/a:' .. lombok_path, -- クラスパスにLombokを追加
      '-data', workspace_path .. project_name
    },
    settings = {
      java = {
        configuration = {
          updateBuildConfiguration = "automatic",
          -- runtimes セクションを削除してデフォルトのJavaランタイムを使用
        },
        maven = {
          downloadSources = true,
        },
        implementationsCodeLens = {
          enabled = true,
        },
        referencesCodeLens = {
          enabled = true,
        },
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
        codeGeneration = {
          toString = {
            template = "${object.className}{${member.name}=${member.value}, ${otherMembers}}"
          },
          hashCodeEquals = {
            useJava7Objects = true,
          },
        },
      },
    },
    init_options = {
      bundles = {},
      extendedClientCapabilities = {
        progressReportProvider = true,
        classFileContentsSupport = true -- クラスファイルの内容サポート
      }
    },
    single_file_support = true,
  }

  return opts
end

return M
