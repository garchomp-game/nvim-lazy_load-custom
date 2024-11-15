local utils = require('utils')
local load_event = utils.get_is_initial_setup_done() and 'VimEnter' or 'VeryLazy'

return {
  -- mason-lspconfigの設定
  {
    'williamboman/mason-lspconfig.nvim',
    event = load_event,
    dependencies = {
      'williamboman/mason.nvim',
      'hrsh7th/nvim-cmp',
      'folke/neodev.nvim'
    },
    config = function()
      -- 既存のLSP設定
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true, silent = true })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true })

      local is_termux = utils.is_termux
      local language_server_list = {
        "jdtls",
        "ts_ls",
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
      mason_lspconfig.setup {
        ensure_installed = language_server_list,
      }

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local mason_registry = require('mason-registry')

      -- 言語サーバーごとの設定を別ファイルから読み込む
      local server_settings = {
        lua_ls = require('plugins.lsp.lua_ls'),
        jdtls = require('plugins.lsp.jdtls'),
        ts_ls = require('plugins.lsp.ts_ls'),
      }

      for _, server in ipairs(language_server_list) do
        local opts = {
          capabilities = capabilities,
        }

        if server == "lua_ls" and not is_termux() then
          opts = server_settings.lua_ls.custom_server_opts(opts)
        elseif server == "jdtls" then
          opts = server_settings.jdtls.custom_server_opts(opts)
        elseif server == "ts_ls" then
          opts = server_settings.ts_ls.custom_server_opts(opts, mason_registry)
        elseif server == "volar" then
          -- volarの設定を追加
          opts.filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
        end

        require("lspconfig")[server].setup(opts)
      end
    end,
  },

  -- mason.nvimの設定
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
        -- "markdownlint",
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
        mr.refresh(function()
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

  -- nvim-dapの設定
  {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    dependencies = {
      {
        'jayp0521/mason-nvim-dap.nvim',
        config = true
      },
    },
    config = function()
      -- デバッグ用キーマッピング
      vim.keymap.set('n', '<F5>', ":lua require'dap'.continue()<CR>")
      vim.keymap.set('n', '<F10>', ":lua require'dap'.step_over()<CR>")
      vim.keymap.set('n', '<F11>', ":lua require'dap'.step_into()<CR>")
      vim.keymap.set('n', '<F12>', ":lua require'dap'.step_out()<CR>")
      vim.keymap.set('n', '<leader>b', ":lua require'dap'.toggle_breakpoint()<CR>")
      vim.keymap.set('n', '<leader>B', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
      vim.keymap.set('n', '<leader>dr', ":lua require'dap'.repl.open()<CR>")

      local dap = require('dap')

      -- Python のデバッグ設定
      dap.adapters.python = {
        type = 'executable',
        command = 'python',
        args = { '-m', 'debugpy.adapter' },
      }
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          pythonPath = function()
            return '/usr/bin/python'
          end,
        },
      }

      -- C/C++/Rust のデバッグ設定
      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        }
      }
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

      -- JavaScript/TypeScript のデバッグ設定
      dap.adapters.node2 = {
        type = 'executable',
        command = 'node',
        args = { os.getenv('HOME') .. '/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
      }
      dap.configurations.javascript = {
        {
          name = 'Launch',
          type = 'node2',
          request = 'launch',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = 'inspector',
          console = 'integratedTerminal',
        },
      }
      dap.configurations.typescript = dap.configurations.javascript
      dap.adapters.java = {
        type = 'executable',
        command = 'java',
        args = {
          '-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044'
        }
      }

      dap.configurations.java = {
        {
          type = 'java',
          request = 'attach',
          name = "Debug (Attach) - Remote",
          hostName = "127.0.0.1",
          port = 1044
        }
      }
    end,
  },

  -- mason-nvim-dapの設定
  {
    'jayp0521/mason-nvim-dap.nvim',
    event = load_event,
    dependencies = {
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = {
          "python",   -- Python デバッグ用のデバッグアダプター
          "codelldb", -- C/C++/Rust デバッグ用
          "node2",    -- Node.js デバッグ用
        },
        automatic_installation = true,
        handlers = {},
      })
    end,
  },
}
