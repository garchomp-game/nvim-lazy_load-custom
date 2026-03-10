-- which-key.nvim: キーバインドヘルパー
-- <leader> を押すと利用可能なキーバインドが一覧表示される
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'helix',  -- モダンな表示スタイル
  },
}
