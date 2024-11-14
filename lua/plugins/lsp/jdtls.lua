-- plugins/lsp/jdtls.lua

local M = {}

function M.custom_server_opts(opts)
  local home = vim.loop.os_homedir()
  local data_path = vim.fn.stdpath("data")
  local workspace_path = data_path .. "/jdtls-workspace/"
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  local lombok_path = data_path .. "/mason/packages/jdtls/lombok.jar"
  
  opts = {
    -- メイン設定
    cmd = {
      'jdtls',
      '--jvm-arg=-javaagent:' .. lombok_path,  -- Lombokの設定
      '--jvm-arg=-Xbootclasspath/a:' .. lombok_path,  -- クラスパスにLombokを追加
      '-data', workspace_path .. project_name
    },
    
    -- 言語サーバーの設定
    settings = {
      java = {
        configuration = {
          updateBuildConfiguration = "automatic",
          -- Lombokのサポートを有効化
          runtimes = {
            {
              name = "JavaSE-11",
              path = home .. "/.sdkman/candidates/java/11.0.x",
            }
          }
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
        -- コード生成の設定
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
    
    -- 初期化オプション
    init_options = {
      bundles = {},
      extendedClientCapabilities = {
        progressReportProvider = true,
        classFileContentsSupport = true  -- クラスファイルの内容サポート
      }
    },

    -- シングルファイルのサポート
    single_file_support = true,
  }
  
  return opts
end

return M
