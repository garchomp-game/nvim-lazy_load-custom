return {
  "aznhe21/actions-preview.nvim",
  keys = {
    {
      "<leader>gf",
      function()
        require("actions-preview").code_actions()
      end,
      mode = { "n", "v" },
      desc = "コードアクションプレビュー",
    },
  },
}
