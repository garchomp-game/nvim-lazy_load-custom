---@diagnostic disable: inject-field
return {
  'rcarriga/nvim-dap-ui',
  {
    'mfussenegger/nvim-dap',
    'folke/neodev.nvim',
    dependencies = {
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      local dap = require("dap")

      -- Lua用のデバッグアダプター設定
      local home = vim.env.HOME
      dap.adapters["local-lua"] = {
        type = "executable",
        command = "node",
        args = {home .. "/local-lua-debugger-vscode/extension/debugAdapter.js"},
        enrich_config = function(config, on_config)
          if not config["extensionPath"] then
            local c = vim.deepcopy(config)
            c.extensionPath = home .. "/local-lua-debugger-vscode/"
            on_config(c)
          else
            on_config(config)
          end
        end,
      }

      -- ここに他の言語や設定を追加
    end,
    opts = function()
      -- ここにオプションの設定を追加
    end,
  }
}
