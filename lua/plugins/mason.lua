local utils = require('utils')
local load_event = utils.get_is_initial_setup_done() and 'VimEnter' or 'VeryLazy'

return {
  {
    'williamboman/mason-lspconfig.nvim',
    event = load_event,
    dependencies = {
      'williamboman/mason.nvim',
      'hrsh7th/nvim-cmp',
      'folke/neodev.nvim' -- neodevを追加
    },
    config = function()
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {noremap = true, silent = true})
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {noremap = true, silent = true})
      local is_termux = utils.is_termux
      local language_server_list = {
        "jdtls",
        "tsserver",
        "cssls",
        "vimls",
        "bashls",
        "emmet_ls",
        "eslint",
        "volar",
        "intelephense",
        "phpactor",
        "psalm",
      }

      if not is_termux() then
        table.insert(language_server_list, "lua_ls")
      end

      local lua_ls = require('plugins.lsp.lua_ls') -- lua_lsの設定をインポート
      local jdtls = require('plugins.lsp.jdtls')
      require("mason-lspconfig").setup{
        ensure_installed = language_server_list,
      }

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      for _, val in pairs(language_server_list) do
        local server_opts = {
          capabilities = capabilities,
        }

        -- lua_ls の特別な設定を別ファイルで行う
        if not is_termux() and val == "lua_ls" then
          server_opts = lua_ls.custom_server_opts(server_opts)
        elseif val == "jdtls" then
          jdtls.option()
        end
        -- 他のLSPサーバに関する設定
        require("lspconfig")[val].setup(server_opts)
      end
    end,
  },
  {
    'williamboman/mason.nvim',
    event = { load_event },
    config = function()
      local is_termux = utils.is_termux
      local myList = {
        "bash-debug-adapter",
        "bash-language-server",
        "vim-language-server",
        "prettier",
        "json-lsp",
        "textlint",
        "eslint-lsp",
        "vue-language-server",
        "typescript-language-server",
        "intelephense",
        "jdtls",
        "java-language-server",
        "phpactor",
        "psalm",
        "stylua",
      }
      if not is_termux() then
        table.insert(myList, "lua-language-server")
      end

      local function check()
        local mr = require("mason-registry")
        -- パッケージリストを更新し、完了後に各パッケージのインストール状態をチェック
        mr.refresh(function ()
          for _, tool in ipairs(myList) do
            local p = mr.get_package(tool)
            if not p:is_installed() then
              p:install()
            end
          end
        end)
      end

      require("mason").setup()
      -- 初期セットアップが完了したかどうかを確認
      if utils.get_is_initial_setup_done() then
        vim.cmd("Mason")
      end
      check()
    end,
  },
}
