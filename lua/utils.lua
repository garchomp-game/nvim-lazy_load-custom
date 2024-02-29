local M = {}

local is_initial_setup_done = false

-- Termux環境かどうかをチェックする関数
function M.is_termux()
  local prefix = vim.fn.getenv("PREFIX")
  return type(prefix) == "string" and prefix:match('/com.termux')
end

-- is_initial_setup_doneの値を取得するgetter関数
function M.get_is_initial_setup_done()
  return is_initial_setup_done
end

-- is_initial_setup_doneの値を設定するsetter関数
function M.set_is_initial_setup_done(value)
  assert(type(value) == "boolean", "Value must be a boolean")
  is_initial_setup_done = value
end

function M.setup_very_lazy(callbackFn)
  -- VeryLazy イベントのための autocmd を作成
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = callbackFn
  })
  M.autocmd(
    "User",
    {
      pattern = "VeryLazy",
      callback = callbackFn
    }
  )
end

-- autocmdを設定する関数
function M.autocmd(event, params, opts)
  -- optsがnilの場合、空のテーブルをデフォルト値とする
  opts = opts or {}

  -- nvim_create_autocmdに渡すオプションテーブルを構築
  local autocmd_opts = {
    pattern = params.pattern or "*", -- パターンが指定されていない場合のデフォルト値
    group = vim.api.nvim_create_augroup(params.group or "VimEnter", {}),
    callback = params.callback,
    -- 追加のオプションがあればここに含める
  }

  -- イベントとオプションを使用してautocmdを作成
  vim.api.nvim_create_autocmd(event, autocmd_opts)
end

function M.print_table(t, indent)
  indent = indent or ""
  if type(t) ~= "table" then
    print(indent .. tostring(t))
  else
    for k, v in pairs(t) do
      if type(v) == "table" then
        print(indent .. tostring(k) .. ":")
        M.print_table(v, indent .. "  ")
      else
        print(indent .. tostring(k) .. ": " .. tostring(v))
      end
    end
  end
end

---指定されたツールがシステム上で実行可能かどうかをチェックします。
---@param name string チェックするツールの名前。
---@return boolean `true` が返る場合、ツールは実行可能です。そうでなければ `false`。
function M.tool_exists(name)
  return vim.fn.executable(name) > 0
end

function M.VertTerm(size)
  size = size or 95 -- デフォルトサイズを95に設定
  vim.cmd("ToggleTerm direction=vertical size=" .. size)
end

---@param callback function 設定されたTermux環境の場合、callback関数が呼び出されます。
---@return table
function M.setup_non_termux_config(callback)
    if not M.is_termux() then
        return callback()
    else
        return {}
    end
end

return M
