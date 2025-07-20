-- /plugins/mason.lua (修正版)

local utils = require('utils')
local load_event = utils.get_is_initial_setup_done() and 'VimEnter' or 'VeryLazy'

return {
  {
    'williamboman/mason-lspconfig.nvim',
    event = load_event,
    dependencies = {
      'williamboman/mason.nvim',
      'hrsh7th/nvim-cmp',
      'folke/neodev.nvim',
    },
    config = function()
      -- 1. masonをセットアップ (ここは変更なし)
      require('mason').setup({
        ensure_installed = {
          -- ▼ LSPサーバー
          "jdtls",
          "typescript-language-server",
          "vue-language-server",
          "css-lsp",
          "bash-language-server",
          "emmet-ls",
          "intelephense",
          "phpactor",
          "json-lsp",
          "lua-language-server",
          -- ▼ フォーマッタ & リンター
          "biome",
          "prettier",
          "stylua",
        },
      })

      -- 2. mason-lspconfigをセットアップ (ここからが修正箇所)
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- `setup_handlers` は廃止されたため、`setup`の`handlers`オプションに統合します
      require("mason-lspconfig").setup({
        -- ここには `lspconfig` でのサーバー名を指定します
        ensure_installed = {
          "jdtls",
          "ts_ls",
          "cssls",
          "bashls",
          "emmet_ls",
          "intelephense",
          "phpactor",
          "jsonls",
          "lua_ls",
        },
        -- handlersをここに定義します
        handlers = {
          -- デフォルトのハンドラ: ほとんどのLSPサーバーはこれで設定が完了します
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,

          -- 個別の設定が必要なサーバーは、ここで上書きします
          ["ts_ls"] = function()
            local settings = require('plugins.lsp.ts_ls')
            lspconfig.ts_ls.setup(settings.custom_server_opts({ capabilities = capabilities }))
          end,

          ["lua_ls"] = function()
            if utils.is_termux() then return end
            local settings = require('plugins.lsp.lua_ls')
            lspconfig.lua_ls.setup(settings.custom_server_opts({ capabilities = capabilities }))
          end,

          ["jdtls"] = function()
            local settings = require('plugins.lsp.jdtls')
            lspconfig.jdtls.setup(settings.custom_server_opts({ capabilities = capabilities }))
          end,
        },
      })

      -- キーマップ設定 (ここは変更なし)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true, silent = true })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true })
    end,
  },
}
