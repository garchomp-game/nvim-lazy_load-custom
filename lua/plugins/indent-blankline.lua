return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = {
      highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      },
    },
    scope = {
      enabled = true,
      show_start = true,
      show_end = false,
    },
    viewport_buffer = {
      min = 30,
      max = 500,
    },
  },
  config = function(_, opts)
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)

    -- カーソルラインとカラムの設定
    vim.opt.cursorline = true
    vim.opt.cursorcolumn = true
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2C323C" })
    vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#2C323C" })

    -- インデントガイドとカーソルラインの統合
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, function(highlight, buf, row, col)
      if vim.api.nvim_get_current_buf() == buf and vim.api.nvim_win_get_cursor(0)[1] == row then
        return "CursorLine"
      end
      return highlight
    end)

    require("ibl").setup(opts)
  end,
}
