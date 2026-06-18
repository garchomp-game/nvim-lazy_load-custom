# nvim-lazy_load-custom

普段使い向けの Neovim 設定です。`lazy.nvim` でプラグインを管理しつつ、Neovim 0.11+ の標準機能に寄せています。

## 方針

- マウスは無効
- ActivityBar は使わない
- LSP は `nvim-lspconfig` ではなく Neovim 標準の `vim.lsp.config` / `vim.lsp.enable`
- `lsp/*.lua` のファイル名を Mason の自動インストール対象として使う
- Treesitter は `nvim-treesitter` を使わず、Neovim 標準の `vim.treesitter.start()`
- formatter は `conform.nvim`
- lint は `nvim-lint`
- 補完は `blink.cmp`
- buffer tab は `bufferline.nvim`
- Lua LS の plugin 型補助は `lazydev.nvim` に寄せ、plugin API は原則 `require(...)` で明示
- 通知ポップアップは無効化し、`:messages` / `:CopyMessage` を見やすくする

## Requirements

- Neovim 0.11+
- Git
- ripgrep (`rg`)
- Node.js / npm
- unzip, curl or wget
- Nerd Font

LSP server / formatter / linter / debug adapter は `mason.nvim` と `mason-tool-installer.nvim` で管理します。

## Keymaps

Leader key は `<Space>` です。

### File Tree

| Key | Action |
|---|---|
| `<C-n>` | ファイルツリーを開閉 |
| `<leader>e` | ファイルツリーを開閉 |
| `<leader>E` | 現在のファイルをツリーで表示 |
| `<leader>o` | ファイルツリーへ移動 |
| `<leader>be` | bufferツリーを開閉 |
| `<leader>ge` | Git statusツリーを開閉 |

### Buffers

| Key | Action |
|---|---|
| `<Tab>` | 次のbufferへ |
| `<S-Tab>` | 前のbufferへ |
| `<leader>bn` | 次のbufferへ |
| `<leader>bp` | 前のbufferへ |
| `<leader>bf` | bufferを選択 |
| `<leader>bd` | 現在のbufferを閉じる |
| `<leader>bD` | 他のbufferを閉じる |

### Find

| Key | Action |
|---|---|
| `<leader>ff` | ファイル検索 |
| `<leader>fg` | 全文検索 |
| `<leader>fb` | buffer検索 |
| `<leader>fh` | help検索 |
| `<leader>fr` | 最近のファイル |
| `<leader>fw` | カーソル下の単語を検索 |
| `<leader>f/` | 現在buffer内を検索 |
| `<leader>fk` | キーマップ検索 |
| `<leader>fc` | コマンド検索 |
| `<leader>fd` | 診断検索 |

### Terminal

| Key | Action |
|---|---|
| `<C-\>` | ターミナルを開閉 |
| `<leader>tt` | ターミナルを開閉 |
| `<leader>th` | 水平ターミナルを開閉 |
| `<leader>tv` | 垂直ターミナルを開閉 |
| `<leader>tf` | フロートターミナルを開閉 |
| `<leader>ta` | 全ターミナルを開閉 |

### Code

| Key | Action |
|---|---|
| `<leader>f` | format |
| `<leader>cf` | format |
| `<leader>ca` | code action |
| `<leader>gf` | code action preview |
| `<leader>rn` | rename |
| `gd` | 定義へ移動 |
| `gD` | 宣言へ移動 |
| `gy` | 型定義へ移動 |
| `gi` | 実装へ移動 |
| `gr` | 参照一覧 |
| `K` | hover |

`=` は Vim 標準のインデント操作として残しています。

### Debug

| Key | Action |
|---|---|
| `<F5>` | デバッグ開始/続行 |
| `<F10>` | ステップオーバー |
| `<F11>` | ステップイン |
| `<F12>` | ステップアウト |
| `<leader>db` | ブレークポイント |
| `<leader>dB` | 条件付きブレークポイント |
| `<leader>dr` | DAP REPL |
| `<leader>dl` | 最後のデバッグを再実行 |
| `<leader>du` | DAP UI を開閉 |
| `<leader>de` | 式を評価 |

### Shakyo

| Key | Action |
|---|---|
| `<leader>sr` | 写経開始 |
| `<leader>sq` | 写経終了 |
| `<leader>sc` | 写経ヒント |

## Notes

- `nvim-treesitter` を外しているため、parser がない filetype では Treesitter を開始しません。
- Neovim 標準の Lua ftplugin は parser がない環境でも落ちないよう、`vim.treesitter.start()` をガードしています。
- `snacks.nvim` は words / indent / statuscolumn などを使い、notifier は無効にしています。
- `lazydev.nvim` は Neovim Lua 設定の解析補助として使い、サードパーティ plugin の呼び出しは `require(...)` に寄せています。
- `winresizer` は `<leader>wR` から起動します。`<leader>e` は Neo-tree 用です。

## License

MIT License
