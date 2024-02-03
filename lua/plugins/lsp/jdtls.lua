local M = {}

function M.option()
  local data = vim.fn.stdpath('data')
  local lombok = data .. "/mason/packages/jdtls/lombok.jar"

  if vim.fn.filereadable(lombok) then
    vim.env.JDTLS_JVM_ARGS = "-javaagent:" .. lombok
  end
end

return M
