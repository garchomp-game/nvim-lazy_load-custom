return {
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'CmdLineEnter', 'BufRead' },
    dependencies = {
      'williamboman/mason.nvim',
      'hrsh7th/nvim-cmp',
      'folke/neodev.nvim' -- neodevを追加
    },
    opts = function()
      local language_server_list = {
        "intelephense",
        "jdtls",
        "tsserver",
        "cssls",
        "vimls",
        "bashls",
        "emmet_ls",
        "eslint",
        "volar",
        "lua_ls",
      }

      local lua_ls = require('plugins.lsp.lua_ls') -- lua_lsの設定をインポート

      require("mason-lspconfig").setup{
        ensure_installed = language_server_list,
      }

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      for _, val in pairs(language_server_list) do
        local server_opts = {
          capabilities = capabilities,
        }

        -- lua_ls の特別な設定を別ファイルで行う
        if val == "lua_ls" then
          lua_ls.setup()
        else
          -- 他のLSPサーバに関する設定
          require("lspconfig")[val].setup(server_opts)
        end
      end
    end,
  },
  {
    'williamboman/mason.nvim',
    event = { 'CmdLineEnter', 'BufRead' },
    config = function()

      local myList = {
        "intelephense",
        "bash-debug-adapter",
        "bash-language-server",
        "vim-language-server",
        "remark-language-server",
        "prettier",
        "json-lsp",
        "textlint",
        "markdownlint",
        "eslint-lsp",
        "vue-language-server",
        "lua-language-server",
      }


      local function check()
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
