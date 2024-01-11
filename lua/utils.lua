local M = {}

-- Termux環境かどうかをチェックする関数
function M.is_termux()
  local prefix = vim.fn.getenv("PREFIX")
  if type(prefix) == "string" and prefix:match('/com.termux') then
    return true
  else
    return false
  end
end

return M
