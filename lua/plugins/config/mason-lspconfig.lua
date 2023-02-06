local language_server_list = {
  "jdtls",
  "tsserver"
}

require("mason-lspconfig").setup{
  ensure_installed = language_server_list,
}

for _, val in pairs(language_server_list) do
  require("lspconfig")[val].setup {}
end
