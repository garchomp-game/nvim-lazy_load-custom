local M = {}

local is_initial_setup_done = false

-- Termux環境かどうかをチェックする関数
function M.is_termux()
  local prefix = vim.fn.getenv("PREFIX")
  if type(prefix) == "string" and prefix:match('/com.termux') then
    return true
  else
    return false
  end
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

function M.setupVeryLazy(callbackFn)
  -- VeryLazy イベントのための autocmd を作成
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = callbackFn
  })
end

---テーブルの内容を再帰的に表示します。
---@param tbl table 表示するテーブル。
---@param indent? string 現在のインデント（再帰的に使用されます）。オプショナル。
function M.printTableContents(tbl, indent)
    indent = indent or ""
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            print(indent .. tostring(k) .. ": {")
            M.printTableContents(v, indent .. "  ")
            print(indent .. "}")
        else
            print(indent .. tostring(k) .. ": " .. tostring(v))
        end
    end
end

return M
