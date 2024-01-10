-- Termux環境かどうかをチェックする関数
local function is_termux()
  local prefix = vim.fn.getenv("PREFIX")
  if type(prefix) == "string" and prefix:match('/com.termux') then
    return true
  else
    return false
  end
end

-- lua_lsの設定を行う関数
local function setup_lua_ls()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local lazy_nvim_path = vim.fn.stdpath("data") -- lazy.nvimのパスを指定
  local runtime_files = vim.api.nvim_get_runtime_file("", true)
  local library_paths = { lazy_nvim_path }

  -- Neovimのランタイムファイルを追加
  for _, file in ipairs(runtime_files) do
    table.insert(library_paths, file)
  end

  local server_opts = {
    capabilities = capabilities,
  }

  -- Termux環境でない場合のみ設定を適用
  if is_termux() == false then
    server_opts = require("neodev").setup(server_opts)
    server_opts.settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = {'vim', 'require'},
        },
        workspace = {
          library = library_paths,
        },
        telemetry = {
          enable = false,
        },
      }
    }
  end

  require("lspconfig")['lua_ls'].setup(server_opts)
end

return {
  setup = setup_lua_ls
}
