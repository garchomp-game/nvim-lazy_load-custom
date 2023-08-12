return {
  'nvim-lualine/lualine.nvim',
  -- lazy = false,
  event = { 'CmdLineEnter', 'BufRead' },
  opts = function()
    require('lualine').setup {
      options = {
        theme = 'ayu'
      },
    }
  end,
}
