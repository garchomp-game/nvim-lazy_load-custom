-- markdownだったらnonumberにするようにする。
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.number = false
    -- gitsignsの機能を無効化
    require('gitsigns').detach()
  end,
})
