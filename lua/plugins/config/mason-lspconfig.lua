local language_server_list = {
  "jdtls",
  "tsserver",
  "cssls",
  "vimls",
  "html",
  "bashls",
  "emmet_ls"
}

require("mason-lspconfig").setup{
  ensure_installed = language_server_list,
}

for _, val in pairs(language_server_list) do
  require("lspconfig")[val].setup {}
end
