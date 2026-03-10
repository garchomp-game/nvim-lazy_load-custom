-- emmet_ls: Emmet Language Server 設定
return {
  cmd = { 'emmet-ls', '--stdio' },
  filetypes = { 'html', 'css', 'scss', 'vue', 'typescriptreact', 'javascriptreact', 'php', 'blade' },
  root_markers = { '.git', 'package.json' },
}
