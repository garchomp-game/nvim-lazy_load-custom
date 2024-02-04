local M = {}

---指定されたプラグイン名のパスを取得します。
---@param names string[] プラグイン名の配列。
---@return string[] 指定されたプラグインのパスの配列。
local function get_plugin_paths(names)
  local plugins = require("lazy.core.config").plugins
  local paths = {}
  for _, name in ipairs(names) do
    table.insert(paths, vim.fs.joinpath(plugins[name].dir, "lua"))
  end
  return paths
end

---指定されたプラグインと標準パスからライブラリパスを生成します。
---@param plugins string[] 使用するプラグイン名の配列。
---@return string[] ライブラリのパスの配列。
local function library(plugins)
  local paths = get_plugin_paths(plugins)
  local config_path = vim.fn.stdpath("config")
  if type(config_path) ~= "string" then
    -- ここでエラーを通知するか、デフォルト値を設定する
    config_path = ""
  end
  local vimruntime_path = vim.env.VIMRUNTIME

  -- パスの結合を行う
  table.insert(paths, vim.fs.joinpath(config_path, "lua"))
  table.insert(paths, vim.fs.joinpath(vimruntime_path, "lua"))
  table.insert(paths, "${3rd}/luv/library")
  table.insert(paths, "${3rd}/libuv/library")
  table.insert(paths, "${3rd}/busted/library")
  table.insert(paths, "${3rd}/luassert/library")
  return paths
end

---lua_lsのLSP設定を取得します。
---@param server_opts table 予め設定されているserver_opts
---@return table 設定されたserver_opts
function M.custom_server_opts(server_opts)
  server_opts.settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {'vim', 'require'},
      },
      workspace = {
        library = library({"lazy.nvim"}),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    }
  }

  return server_opts
end

return M
