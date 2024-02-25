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
    -- 選択範囲を取得
    local start_line = opts.line1
    local end_line = opts.line2
    -- 選択範囲内での末尾のスペースを削除するExコマンドを構築
    local command = start_line .. "," .. end_line .. "s/\\s\\+$//g"
    -- コマンドを実行
    vim.cmd(command)
  end,
  {range = true} -- コマンドが範囲を受け取れるようにする
)
