---@diagnostic disable: inject-field
return {
  {
    'rcarriga/nvim-dap-ui',
    event = { 'CmdLineEnter', 'BufRead' },
    keys = { '<F5>' },
    config = function()
      vim.api.nvim_set_keymap('n', '<F5>', "<cmd>lua require('dapui').toggle()<CR>", { noremap = true, silent = true })
      require('dapui').setup()
    end
  },
  {
    'tomblind/local-lua-debugger-vscode',
    event = { 'CmdLineEnter', 'BufRead' },
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    run = 'npm install && npm run build',
    -- lazy.nvimのパスに設定を更新
    config = function()
      local dap = require("dap")
      local home = vim.env.HOME

      dap.adapters["local-lua"] = {
        type = "executable",
        command = "node",
        args = {home .. "/.local/share/nvim/lazy/local-lua-debugger-vscode/extension/debugAdapter.js"},
        enrich_config = function(config, on_config)
          if not config["extensionPath"] then
            local c = vim.deepcopy(config)
            c.extensionPath = home .. "/.local/share/nvim/lazy/local-lua-debugger-vscode/"
            on_config(c)
          else
            on_config(config)
          end
        end,
      }

      -- 他の設定...
      require('dapui').setup()
    end
  },
  {
    'mfussenegger/nvim-dap',
    event = { 'CmdLineEnter', 'BufRead' },
    dependencies = {
      'folke/neodev.nvim',
      'tomblind/local-lua-debugger-vscode', -- GitHubリポジトリを直接指定
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      -- Luaでの設定
      local dap = require("dap")
      dap.configurations.lua = {
        {
          name = 'Current file (local-lua-dbg, lua)',
          type = 'local-lua',
          request = 'launch',
          cwd = '${workspaceFolder}',
          program = {
            lua = 'lua5.1',  -- Luaのバージョンを必要に応じて変更してください
            file = '${file}',
          },
          args = {},
        },
      }
    end,
    opts = function()
      -- オプション設定
    end,
  }
}
