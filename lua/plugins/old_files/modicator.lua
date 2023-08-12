return {
  'mawkler/modicator.nvim',
  -- event = { 'CmdLineEnter', 'BufRead' },
  -- dependencies = {
  --   'Shatur/neovim-ayu'
  -- },
  init = function()
    vim.opt.termguicolors = true
    vim.opt.cursorline = true
    vim.opt.number = true
  end,
  config = function()
    require('modicator').setup({
      -- Show warning if any required option is missing
      show_warnings = true,
      highlights = {
        -- Default options for bold/italic
        defaults = {
          bold = false,
          italic = false
        },
      },
    })
  end,
}
