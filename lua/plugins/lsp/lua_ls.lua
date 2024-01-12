local is_termux = require('utils').is_termux

---指定されたプラグイン名のパスを取得します。
---@param names string[] プラグイン名の配列。
---@return string[] 指定されたプラグインのパスの配列。
local function get_plugin_paths(names)
  local plugins = require("lazy.core.config").plugins
  local paths = {}
  for _, name in ipairs(names) do
    if plugins[name] then
      table.insert(paths, vim.fs.joinpath(plugins[name].dir, "lua"))
    else
      vim.notify("Invalid plugin name: " .. name)
    end
  end
  return paths
end

---Neovimのユーザー設定ディレクトリのパスを取得します。
---@return string|nil ユーザー設定ディレクトリのパス。
local function get_config_path()
  local config_path = vim.fn.stdpath("config")
  if type(config_path) == "table" then
    -- 文字列の配列の場合、最初の要素を使用
    config_path = config_path[1]
  end
  return config_path
end

---指定されたプラグインと標準パスからライブラリパスを生成します。
---@param plugins string[] 使用するプラグイン名の配列。
---@return string[] ライブラリのパスの配列。
local function library(plugins)
  local paths = get_plugin_paths(plugins)
  local config_path = get_config_path()
  local vimruntime_path = vim.env.VIMRUNTIME

  -- パスの結合を行う
  table.insert(paths, vim.fs.joinpath(config_path, "lua"))
  table.insert(paths, vim.fs.joinpath(vimruntime_path, "lua"))
  table.insert(paths, "${3rd}/luv/library")
  table.insert(paths, "${3rd}/busted/library")
  table.insert(paths, "${3rd}/luassert/library")
  return paths
end

---lua_lsのLSP設定を行います。
local function setup_lua_ls()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local server_opts = {
    capabilities = capabilities,
  }

  -- Termux環境でない場合のみ設定を適用
  if not is_termux() then
    server_opts = require("neodev").setup(server_opts)
    server_opts.settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = {'vim', 'require'},
          enable = true,
          disable = { "lowercase-global" },  -- 必要に応じて無効にする警告を指定
        },
        workspace = {
          library = library({"lazy.nvim"}),
          checkThirdParty = false,  -- 第三者のライブラリのチェックを行うかどうか
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
