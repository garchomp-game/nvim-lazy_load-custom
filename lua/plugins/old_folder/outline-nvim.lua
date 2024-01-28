return {
  "hedyhli/outline.nvim",
  event = { 'CmdLineEnter', 'BufRead' },
  keys = { '<leader>o' },
  config = function()
    -- Example mapping to toggle outline
    vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
      { desc = "Toggle Outline" })

  end,
}
