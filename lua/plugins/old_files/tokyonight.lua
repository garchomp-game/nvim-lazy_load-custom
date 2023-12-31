return {
  'folke/tokyonight.nvim',
  lazy = false,
  config = function()
    require("tokyonight").setup({
      transparent = true, -- Enable this to disable setting the background color
      styles = {
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
      },
    })
    vim.g.tokyonight_transparent = true  -- 背景を透過させる場合
    vim.cmd[[colorscheme tokyonight-night]]
  end,
}

