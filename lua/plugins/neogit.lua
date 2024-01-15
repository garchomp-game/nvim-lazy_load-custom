return {
  "NeogitOrg/neogit",
  event = { 'CmdLineEnter' },
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration
    "nvim-telescope/telescope.nvim", -- optional
  },
  opts = function()
    local neogit = require('neogit')
    neogit.setup {}
  end
}

