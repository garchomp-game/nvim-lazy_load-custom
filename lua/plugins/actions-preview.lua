return {
  "aznhe21/actions-preview.nvim",
  event = "VeryLazy",
  keys = {
    "<leader>gf"
  },
  config = function()
    vim.keymap.set({ "v", "n" }, "<leader>gf", require("actions-preview").code_actions)
  end,
}

