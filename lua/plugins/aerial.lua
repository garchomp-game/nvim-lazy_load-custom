return {
  "stevearc/aerial.nvim",
  event = { 'CmdLineEnter', 'BufRead' },
  config = function()
    require("aerial").setup {
    }
  end,
}
