return {
  "yukimemi/futago.vim",
  lazy = false,
  dependencies = {
    "vim-denops/denops.vim",
  },
  config = function()
    -- Denopsの設定をLuaで設定
    vim.g['denops#server#deno_args'] = {'-q', '--no-lock', '--unstable-kv', '-A'}

    -- FutagoStartコマンドを追加
    vim.api.nvim_create_user_command('FutagoStart', function()
      vim.cmd('call futago#start_chat()')
    end, {})
  end,
}
