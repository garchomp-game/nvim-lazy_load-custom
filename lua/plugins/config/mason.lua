local myList = {
  "typescript-language-server",
  "css-lsp",
  "cssmodules-language-server",
  "html-lsp",
  "json-lsp",
  "lua-language-server",
  "stylua",
  "shellcheck",
  "shfmt",
  "bash-debug-adapter",
  "bash-language-server",
  "gradle-language-server",
  "groovy-language-server",
  "java-debug-adapter",
  "java-test",
  "jdtls",
  "js-debug-adapter",
  "vim-language-server",
  "remark-language-server",
  "prettier",
  "stylua",
  "shfmt",
  "emmet-ls",
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
