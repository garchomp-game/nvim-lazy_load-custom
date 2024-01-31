return {
  "yukimemi/futago.vim",
  lazy = false,
  dependencies = {
    "vim-denops/denops.vim",
  },
  config = function()
    vim.g['denops#server#deno_args'] = {'-q', '--no-lock', '--unstable-kv', '-A'}
    vim.cmd('command! FutagoStart call futago#start_chat()')
  end
}
