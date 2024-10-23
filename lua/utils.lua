local M = {}

local is_initial_setup_done = false

--- Termux環境かどうかをチェックする関数。
--- Termux環境の場合、PREFIXという環境変数が設定されているため、これを利用して判定します。
---@return boolean `true` が返る場合、Termux環境です。それ以外は `false`。
function M.is_termux()
  local prefix = vim.fn.getenv("PREFIX")
  return type(prefix) == "string" and prefix:match('/com.termux')
end

--- is_initial_setup_doneの値を取得するgetter関数。
--- 設定が完了したかどうかのフラグを返します。
---@return boolean 初期セットアップが完了している場合は `true`。
function M.get_is_initial_setup_done()
  return is_initial_setup_done
end

--- is_initial_setup_doneの値を設定するsetter関数。
--- この関数で初期セットアップの状態を更新します。値はbooleanである必要があります。
---@param value boolean セットアップが完了している場合は `true`、そうでなければ `false`。
function M.set_is_initial_setup_done(value)
  assert(type(value) == "boolean", "Value must be a boolean") -- 値がboolean型であることを確認
  is_initial_setup_done = value
end

--- VeryLazy イベントのための autocmd を作成します。
--- Userイベントの「VeryLazy」パターンに基づいてオートコマンドを設定します。
---@param callback_fn function VeryLazy イベントが発生したときに実行するコールバック関数。
function M.setup_very_lazy(callback_fn)
  M.autocmd("User", { pattern = "VeryLazy", callback = callback_fn })
end

--- autocmdを設定する関数。
--- 指定されたイベントに対して自動コマンドを設定します。
---@param event string イベント名（例："User"、"BufEnter"など）。
---@param params table イベントのパラメータ（pattern、group、callbackなど）。
function M.autocmd(event, params)
  -- nvim_create_autocmdに渡すオプションテーブルを構築
  local autocmd_opts = {
    pattern = params.pattern or "*", -- パターンが指定されていない場合は全てに適用
    group = vim.api.nvim_create_augroup(params.group or "VimEnter", {}), -- autocmdグループを作成
    callback = params.callback, -- autocmdで実行するコールバック関数
  }

  -- イベントとオプションを使用してautocmdを作成
  vim.api.nvim_create_autocmd(event, autocmd_opts)
end

--- テーブルの内容をプリントする関数。
--- テーブルの内容を再帰的に出力します。インデントを使ってネスト構造を表現します。
---@param t table 出力したいテーブル。
---@param indent string|nil インデント文字列。再帰的な呼び出しの際に使用。
function M.print_table(t, indent)
  indent = indent or ""
  if type(t) ~= "table" then
    print(indent .. tostring(t)) -- テーブルでない場合はそのまま出力
  else
    for k, v in pairs(t) do
      if type(v) == "table" then
        print(indent .. tostring(k) .. ":") -- テーブルのキーを出力
        M.print_table(v, indent .. "  ") -- 再帰的にネストされたテーブルを出力
      else
        print(indent .. tostring(k) .. ": " .. tostring(v)) -- 値を出力
      end
    end
  end
end

--- 指定されたツールがシステム上で実行可能かどうかをチェックします。
--- vim.fn.executable()関数を使用して、ツールが実行可能かを確認します。
---@param name string チェックするツールの名前。
---@return boolean `true` が返る場合、ツールは実行可能です。そうでなければ `false`。
function M.tool_exists(name)
  return vim.fn.executable(name) > 0
end

--- 垂直方向のターミナルを開く関数。
--- デフォルトで90のサイズで垂直方向のターミナルを開きます。
---@param size number|nil ターミナルのサイズ（省略時は90）。
function M.VertTerm(size)
  size = size or 90 -- デフォルトサイズを90に設定
  vim.cmd("ToggleTerm direction=vertical size=" .. size) -- ターミナルを垂直に開く
end

--- Termux環境でない場合に設定を行う関数。
--- Termux環境ではコールバックは実行されません。
---@param callback function 設定されたTermux環境でない場合に呼び出されるコールバック関数。
---@return table コールバック関数の結果または空のテーブル。
function M.setup_non_termux_config(callback)
  if not M.is_termux() then
    return callback() -- Termux環境でなければコールバックを実行
  else
    return {} -- Termux環境の場合は空のテーブルを返す
  end
end

function M.unique_merge(list1, list2)
  local seen = {}
  local result = {}

  for _, v in ipairs(list1) do
    if not seen[v] then
      table.insert(result, v)
      seen[v] = true
    end
  end

  for _, v in ipairs(list2) do
    if not seen[v] then
      table.insert(result, v)
      seen[v] = true
    end
  end

  return result
end

return M
