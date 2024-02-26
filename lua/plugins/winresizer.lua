return {
  'simeji/winresizer',
  event = "VeryLazy",
  init = function()
    vim.g.winresizer_start_key = "<leader>e"
    vim.g.winresizer_vert_resize = 1
    vim.g.winresizer_horiz_resize = 1
  end
}
