-- markdownだったらnonumberにするようにする。
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.number = false
  end,
})
