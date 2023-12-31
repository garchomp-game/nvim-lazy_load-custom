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

      local lazy_nvim_path = vim.fn.stdpath("data")-- lazy.nvimのパスを指定
      local runtime_files = vim.api.nvim_get_runtime_file("", true)
      local library_paths = { lazy_nvim_path }
      for _, val in pairs(language_server_list) do
        local server_opts = {
          capabilities = capabilities
        }

        -- Neovimのランタイムファイルを追加
        for _, file in ipairs(runtime_files) do
          table.insert(library_paths, file)
        end
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
                library = library_paths,
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
    -- event = { 'CmdLineEnter', 'BufRead' },
    lazy = false,
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
