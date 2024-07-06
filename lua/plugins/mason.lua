
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
        "volar",
        "bashls",
        "emmet_ls",
        "eslint",
        "intelephense",
        "phpactor",
        "psalm",
      }

      if not is_termux() then
        table.insert(language_server_list, "lua_ls")
        table.insert(language_server_list, "phpactor")
        table.insert(language_server_list, "psalm")
      end

      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup{
        ensure_installed = language_server_list,
      }

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local mason_registry = require('mason-registry')

      -- 言語サーバーごとの設定を別ファイルから読み込む
      local server_settings = {
        lua_ls = require('plugins.lsp.lua_ls'),
        jdtls = require('plugins.lsp.jdtls'),
        tsserver = require('plugins.lsp.tsserver')
      }

      for _, server in ipairs(language_server_list) do
        local opts = {
          capabilities = capabilities,
        }

        if server == "lua_ls" and not is_termux() then
          opts = server_settings.lua_ls.custom_server_opts(opts)
        elseif server == "jdtls" then
          opts = server_settings.jdtls.option()
        elseif server == "tsserver" then
          opts = server_settings.tsserver.custom_server_opts(opts, mason_registry)
        elseif server == "volar" then
          opts.filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
        end

        require("lspconfig")[server].setup(opts)
      end
    end,
  },
  {
    'williamboman/mason.nvim',
    event = { load_event },
    config = function()
      local is_termux = utils.is_termux
      local tool_list = {
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
        "phpactor",
        "psalm",
        "stylua",
        "markdownlint",
        "eslint_d",
        "eslint-lsp",
      }
      if not is_termux() then
        table.insert(tool_list, "lua-language-server")
        table.insert(tool_list, "phpactor")
        table.insert(tool_list, "psalm")
      end

      local function check_installation()
        local mr = require("mason-registry")
        mr.refresh(function ()
          for _, tool in ipairs(tool_list) do
            local pkg = mr.get_package(tool)
            if not pkg:is_installed() then
              pkg:install()
            end
          end
        end)
      end

      require("mason").setup()
      if utils.get_is_initial_setup_done() then
        vim.cmd("Mason")
      end
      check_installation()
    end,
  },
}

