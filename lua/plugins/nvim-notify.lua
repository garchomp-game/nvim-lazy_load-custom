return {
  'rcarriga/nvim-notify',
  lazy = false,
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    vim.notify = require("notify")
    require('telescope').extensions.notify.notify()
  end
}
