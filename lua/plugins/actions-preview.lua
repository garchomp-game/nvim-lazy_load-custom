return {
  "aznhe21/actions-preview.nvim",
  event = "VeryLazy",
  keys = {
    "gf"
  },
  config = function()
    vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
  end,
}

