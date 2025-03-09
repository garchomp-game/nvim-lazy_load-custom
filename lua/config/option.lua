-- ===============================
-- Neovide（GUI版 Neovim）の設定
-- ===============================

-- ● パフォーマンス・描画関連の設定

-- リフレッシュレート設定
-- ・通常時はモニターのリフレッシュレート（例：144Hz）に合わせる
vim.g.neovide_refresh_rate = 144
-- ・非アクティブ時は負荷軽減のため低速（例：5fps）にする
vim.g.neovide_refresh_rate_idle = 5

-- フルスクリーン起動
vim.g.neovide_fullscreen = true

-- アイドル時も常に描画することで、選択範囲やカーソルの更新が途切れないようにする
vim.g.neovide_no_idle = true

-- ウィンドウリサイズ時のアニメーションを無効にして、即時更新で違和感を低減
vim.g.neovide_animate_window_resize = false

-- ● アニメーション・エフェクトの無効化設定（高速動作・自然な見た目を重視）

-- カーソル移動時のアニメーションを無効に（0秒＝即時更新）
vim.g.neovide_cursor_animation_length = 0
-- スクロール時のアニメーションを無効にして、画面更新を即時反映
vim.g.neovide_scroll_animation_length = 0
-- カーソルの残像（トレイル）効果を無効化
vim.g.neovide_cursor_trail_length = 0.0
-- カーソルの特殊エフェクト（VFX）をオフにして、シンプルな描画に
vim.g.neovide_cursor_vfx_mode = ""

-- ● UI・見た目の調整

-- 背景色の設定（Neovideでは背景色に透過効果を付けることも可能）
vim.g.neovide_background_color = "#282c34" .. string.format("%x", math.floor(255 * 0.8))
-- 前回終了時のウィンドウサイズを記憶し、次回起動時に復元する
vim.g.neovide_remember_window_size = true

-- ===============================
-- Neovim 本体の基本設定（既存の設定例）
-- ===============================

local utils = require('utils')

-- ヘルプ言語設定（日本語と英語）
vim.opt.helplang = 'ja,en'
-- インデント関連設定
vim.opt.expandtab = true      -- タブをスペースに展開
vim.opt.tabstop = 2           -- タブ幅を 2 に設定
vim.opt.shiftwidth = 2        -- 自動インデントの幅を 2 に設定
-- マウス設定（ここでは無効化）
vim.opt.mouse = ""
-- 相対行番号の表示（falseの場合は絶対行番号）
vim.opt.relativenumber = false
if utils.is_termux() then
  vim.opt.number = false
else
  vim.opt.number = true
end
vim.opt.cursorcolumn = false  -- カーソル行のハイライトを無効化
vim.opt.showcmd = true        -- コマンドの一部表示を有効化
vim.opt.ruler = true          -- 画面下部にカーソル位置を表示
vim.opt.ignorecase = true     -- 検索時の大文字・小文字を無視
vim.opt.foldenable = false    -- 自動折りたたみを無効化
vim.opt.termguicolors = true  -- True Color を有効に（GUIに最適）

-- Markdown 関連の設定
vim.g.markdown_recommended_style = 0

-- ===============================
-- クリップボードやその他の設定
-- ===============================

-- 遅延読み込みを利用して、クリップボードをシステムのものに統一
utils.setup_very_lazy(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- WSL 環境の場合、Windows のクリップボードユーティリティ（win32yank）を使用
if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = "win32yank",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf"
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf"
    },
    cache_enable = 0,
  }
end
