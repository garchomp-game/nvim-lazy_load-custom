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

return M
