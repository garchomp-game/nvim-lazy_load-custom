return {
  {
    'jbyuki/one-small-step-for-vimkind',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'mfussenegger/nvim-dap',
    event = { 'CmdLineEnter', 'BufRead' },
    dependencies = {
      'jbyuki/one-small-step-for-vimkind',
    },
    keys = {
      '<F5>',
    },
    config = function()
      local dap = require"dap"
      dap.configurations.lua = {
        {
          type = 'nlua',
          request = 'attach',
          name = "Attach to running Neovim instance",
        }
      }

      dap.adapters.nlua = function(callback, config)
        ---@diagnostic disable-next-line: undefined-field
        callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
      end
      vim.api.nvim_set_keymap('n', '<F5>', [[:lua require"osv".launch({port = 8086})<CR>]], { noremap = true })
    end
  }
}
