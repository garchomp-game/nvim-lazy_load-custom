return {
  "hedyhli/outline.nvim",
  event = { 'CmdLineEnter', 'BufRead' },
  keys = {
    { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle Outline" },
  },
  config = true
}
