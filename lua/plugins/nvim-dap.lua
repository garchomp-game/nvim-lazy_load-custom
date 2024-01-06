---@diagnostic disable: inject-field
return {
  {
    'rcarriga/nvim-dap-ui',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'tomblind/local-lua-debugger-vscode', -- GitHubリポジトリを直接指定
    event = { 'CmdLineEnter', 'BufRead' },
    run = 'npm install && npm run build'  -- ビルドコマンドを指定
  },
  {
    'mfussenegger/nvim-dap',
    event = { 'CmdLineEnter', 'BufRead' },
    dependencies = {
      'folke/neodev.nvim',
      'tomblind/local-lua-debugger-vscode', -- GitHubリポジトリを直接指定
      'rcarriga/nvim-dap-ui',
    },
    keys = { '<F5>' },
    config = function()
      local dap = require("dap")

      -- Luaでの設定
      vim.api.nvim_set_keymap('n', '<F5>', "<cmd>lua require('dapui').toggle()<CR>", { noremap = true, silent = true })

      local home = vim.env.HOME
      dap.adapters["local-lua"] = {
        type = "executable",
        command = "node",
        args = {home .. "/.local/share/nvim/lazy/local-lua-debugger-vscode/extension/debugAdapter.js"},
        enrich_config = function(config, on_config)
          if not config["extensionPath"] then
            local c = vim.deepcopy(config)
            c.extensionPath = home .. "/.local/share/nvim/local-lua-debugger-vscode/local-lua-debugger-vscode/"
            on_config(c)
          else
            on_config(config)
          end
        end,
      }
      require('dapui').setup()
    end,
    opts = function()
      -- オプション設定
    end,
  }
}
