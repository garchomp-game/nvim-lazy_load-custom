vim.api.nvim_create_user_command(
  'CopyMessage',
  function()
    vim.cmd('redir @+ | messages | redir END')
  end,
  {}
)
vim.api.nvim_create_user_command(
  'TrimTrailingSpace',
  function(opts)
    local start_line = opts.line1
    local end_line = opts.line2
    local command = start_line .. "," .. end_line .. "s/\\s\\+$//ge"
    vim.cmd(command)
    vim.cmd("noh")
  end,
  {range = true}
)
