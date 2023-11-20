return {
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'CmdLineEnter', 'BufRead' },
    dependencies = {
      'williamboman/mason.nvim',
      'hrsh7th/nvim-cmp'
    },
    opts = function()

      local language_server_list = {
        "phpactor",
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
    end,
  },
  {
    'williamboman/mason.nvim',
    event = { 'CmdLineEnter', 'BufRead' },
    opts = function()

      local myList = {
        "phpactor",
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
    end,
  },
}
