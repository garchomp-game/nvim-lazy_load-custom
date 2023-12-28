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

      require("mason-lspconfig").setup{
        ensure_installed = language_server_list,
      }

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      for _, val in pairs(language_server_list) do
        local server_opts = {
          capabilities = capabilities
        }

        -- lua_ls の特別な設定
        if val == "lua_ls" then
          server_opts.settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
              },
              diagnostics = {
                globals = {'vim', 'require'},
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
              },
              telemetry = {
                enable = false,
              },
            }
          }
        end

        require("lspconfig")[val].setup(server_opts)
      end
    end,
  },
  {
    'williamboman/mason.nvim',
    event = { 'CmdLineEnter', 'BufRead' },
    opts = function()

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
