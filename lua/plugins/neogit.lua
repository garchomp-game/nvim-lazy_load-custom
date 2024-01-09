return {
  "NeogitOrg/neogit",
  event = { 'CmdLineEnter', 'BufRead' },
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    -- Only one of these is needed, not both.
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = function()
    local neogit = require('neogit')
    neogit.setup {}
  end
}
