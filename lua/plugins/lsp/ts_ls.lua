-- /plugins/lsp/ts_ls.lua

local M = {}

function M.custom_server_opts(opts)
  -- Vue関連のロジックはすべて不要になったため削除しました。
  -- もしTypeScriptサーバー自体に特別な設定があればここに記述しますが、
  -- なければこの関数は空のままで問題ありません。
  
  -- 例えば、フォーマット設定など、ts_ls固有の設定はここに残せます。
  opts.settings = {
    typescript = {
      format = {
        enable = true,
      },
    },
    javascript = {
      format = {
        enable = true,
      },
    },
  }

  return opts
end

return M
