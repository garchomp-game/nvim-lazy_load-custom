-- intelephense: PHP Language Server 設定
return {
  cmd = { 'intelephense', '--stdio' },
  filetypes = { 'php' },
  root_markers = { 'composer.json', '.git' },
}
