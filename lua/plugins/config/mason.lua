local myList = {
  "shfmt",
  "bash-debug-adapter",
  "bash-language-server",
  "vim-language-server",
  "remark-language-server",
  "prettier",
  "json-lsp",
  "textlint",
  "markdownlint",
}


function check()
  local mr = require("mason-registry")
  for _, tool in ipairs(myList) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end
end

require("mason").setup()
check()
