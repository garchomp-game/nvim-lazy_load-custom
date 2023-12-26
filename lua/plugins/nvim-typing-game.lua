return {
  'garchomp-game/nvim-typing-game',
  dev = "true",
  event = { 'CmdLineEnter', 'BufRead' },
  keys = { '<leader>t' },
  config = function()
    vim.api.nvim_set_keymap(
      'n',
      '<leader>t',
      ":Lazy reload nvim-typing-game<CR>:MyFirstFunction<CR>",
      { noremap = true, silent = true }
    )
  end,
}
