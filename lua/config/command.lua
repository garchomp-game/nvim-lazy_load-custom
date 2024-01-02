vim.api.nvim_create_user_command(
  'CopyMessage',
  function()
    vim.cmd('redir @+ | messages | redir END')
  end,
  {}
)

