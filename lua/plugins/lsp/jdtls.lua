-- plugins/lsp/jdtls.lua

local M = {}

function M.custom_server_opts(opts)
  local home = os.getenv('HOME')
  local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  
  opts = {
    -- メイン設定
    cmd = {
      'jdtls',
      '--jvm-arg=-javaagent:' .. home .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar',
      '-data', workspace_path .. project_name
    },
    
    -- 言語サーバーの設定
    settings = {
      java = {
        configuration = {
          updateBuildConfiguration = "automatic",
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
        format = {
          enabled = true,
        },
      },
    },
    
    -- 初期化オプション
    init_options = {
      bundles = {},
      extendedClientCapabilities = {
        progressReportProvider = true
      }
    },

    -- シングルファイルのサポート
    single_file_support = true,
  }
  
  return opts
end

return M
