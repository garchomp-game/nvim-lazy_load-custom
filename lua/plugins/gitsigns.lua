local utils = require('utils')

utils.setup_non_termux_config(function()
  return {
    'lewis6991/gitsigns.nvim',
    event = { 'BufRead', 'BufNewFile' }, -- BufReadとBufNewFileイベント時に読み込む
    config = function(_, opts)
      require('gitsigns').setup(opts)
    end,
    opts = {
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
      auto_attach = true,
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    }
  }
end)
