local language_server_list = {
  "jdtls",
  "tsserver",
  "cssls",
  "vimls",
  "bashls",
  "emmet_ls",
}

require("mason-lspconfig").setup{
  ensure_installed = language_server_list,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
for _, val in pairs(language_server_list) do
  require("lspconfig")[val].setup {
    capabilities = capabilities
  }
end
