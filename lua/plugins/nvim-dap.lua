-- nvim-dap: Debug Adapter Protocol セットアップ
-- DAP コア + UI + Mason連携 を統合管理

return {
  -- DAP コアクライアント
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- DAP UI（変数/スタック/ブレークポイント表示）
      {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'nvim-neotest/nvim-nio' },
        opts = {},
      },
      -- 変数の値をコード横にインライン表示
      {
        'theHamsta/nvim-dap-virtual-text',
        opts = {},
      },
      -- Mason ↔ DAP 連携（アダプターの自動インストール・設定）
      {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = { 'williamboman/mason.nvim' },
        opts = {
          ensure_installed = {
            'js-debug-adapter',     -- JS/TS (Node + Chrome)
            'php-debug-adapter',    -- PHP (Xdebug)
            'java-debug-adapter',   -- Java
            'java-test',            -- Java テスト
          },
          -- 自動設定ハンドラ: mason-nvim-dap が adapters/configurations を自動生成
          handlers = {},
        },
      },
    },

    -- キーマップでの遅延読み込み
    keys = {
      { '<F5>',       function() require('dap').continue() end,          desc = 'デバッグ: 続行/開始' },
      { '<F10>',      function() require('dap').step_over() end,         desc = 'デバッグ: ステップオーバー' },
      { '<F11>',      function() require('dap').step_into() end,         desc = 'デバッグ: ステップイン' },
      { '<F12>',      function() require('dap').step_out() end,          desc = 'デバッグ: ステップアウト' },
      { '<leader>b',  function() require('dap').toggle_breakpoint() end, desc = 'ブレークポイント' },
      { '<leader>B',  function()
          require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end, desc = '条件付きブレークポイント' },
      { '<leader>dr', function() require('dap').repl.open() end,         desc = 'DAP REPL' },
      { '<leader>dl', function() require('dap').run_last() end,          desc = '最後のデバッグを再実行' },
      { '<leader>du', function() require('dapui').toggle() end,          desc = 'DAP UI トグル' },
      { '<leader>de', function() require('dapui').eval() end,            desc = '式を評価', mode = { 'n', 'v' } },
    },

    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      -- DAP UI をデバッグセッションに連動して自動開閉
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      -- ブレークポイントの見た目をカスタマイズ
      vim.fn.sign_define('DapBreakpoint', {
        text = '',
        texthl = 'DiagnosticError',
        linehl = '',
        numhl = '',
      })
      vim.fn.sign_define('DapBreakpointCondition', {
        text = '',
        texthl = 'DiagnosticWarn',
        linehl = '',
        numhl = '',
      })
      vim.fn.sign_define('DapLogPoint', {
        text = '',
        texthl = 'DiagnosticInfo',
        linehl = '',
        numhl = '',
      })
      vim.fn.sign_define('DapStopped', {
        text = '→',
        texthl = 'DiagnosticOk',
        linehl = 'DapStoppedLine',
        numhl = '',
      })
      vim.fn.sign_define('DapBreakpointRejected', {
        text = '',
        texthl = 'DiagnosticError',
        linehl = '',
        numhl = '',
      })

      -- DapStopped 行のハイライト
      vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#2e4d3d' })

      -- ==============================
      -- PHP (Xdebug) 設定
      -- ==============================
      -- mason-nvim-dap の handlers={} で pwa-node 等は自動設定されるが、
      -- PHP は手動設定が必要な場合がある
      if not dap.adapters['php'] then
        dap.adapters['php'] = {
          type = 'executable',
          command = vim.fn.stdpath('data') .. '/mason/bin/php-debug-adapter',
        }
      end

      if not dap.configurations['php'] then
        dap.configurations['php'] = {
          {
            type = 'php',
            request = 'launch',
            name = 'Listen for Xdebug',
            port = 9003,
          },
        }
      end
    end,
  },
}
