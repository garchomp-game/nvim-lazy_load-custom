return {
  {
    -- nvim-dapのメインプラグイン
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    dependencies = {
      -- nvim-dap-ui が必要とする nvim-nio
      'nvim-neotest/nvim-nio',
      -- デバッグUIを提供するプラグイン
      {
        'rcarriga/nvim-dap-ui',
        config = true
      },
      -- MasonによるDAPアダプターの管理を提供するプラグイン
      {
        'jay-babu/mason-nvim-dap.nvim',
        config = function()
          require('mason-nvim-dap').setup({
            ensure_installed = { 'javadbg', 'java-test' },
            automatic_installation = true,
          })
        end,
      },
      -- DAPアダプターの実行に必要な工具の管理をMasonに統合
      'williamboman/mason.nvim',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      -- DAPアダプターや言語別のデバッグ設定をここで行う
      dap.adapters.java = {
        type = 'executable',
        command = 'java-debug-adapter', -- java-debug-adapter のパスを指定
      }
      dap.configurations.java = {
        {
          type = 'java',
          request = 'attach',
          name = 'Attach to Java Debug',
          hostName = '127.0.0.1',
          port = 5005,
        },
      }

      -- nvim-dap-uiの設定
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      -- キーバインドなどの設定
      vim.keymap.set('n', '<F5>', function() dap.continue() end, { noremap = true, silent = true })
      vim.keymap.set('n', '<F10>', function() dap.step_over() end, { noremap = true, silent = true })
      vim.keymap.set('n', '<F11>', function() dap.step_into() end, { noremap = true, silent = true })
      vim.keymap.set('n', '<F12>', function() dap.step_out() end, { noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end, { noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>B', function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>lp', function()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end, { noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>dr', function() dap.repl.toggle() end, { noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end, { noremap = true, silent = true })
    end,
  },
}
