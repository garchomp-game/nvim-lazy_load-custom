return {
  "KKrampis/codex.nvim",
  lazy = true,
  cmd = { "Codex", "CodexToggle" },
  keys = {
    {
      "<leader>ac",
      function()
        require("codex").toggle()
      end,
      desc = "Codex: toggle",
      mode = { "n", "t" },
    },
  },
  opts = {
    cmd = "codex",
    autoinstall = false,
    border = "rounded",
    width = 0.3,
    height = 0.85,
    panel = true,
    use_buffer = false,
    keymaps = {
      quit = "<C-q>",
      toggle = nil,
    },
  },
  config = function(_, opts)
    require("codex").setup(opts)
  end,
}
