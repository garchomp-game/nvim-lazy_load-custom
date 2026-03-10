-- ts_ls: TypeScript Language Server 設定
return {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  settings = {
    typescript = {
      format = {
        enable = true,
      },
    },
    javascript = {
      format = {
        enable = true,
      },
    },
  },
}
