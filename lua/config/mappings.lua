-- オプションを設定: キーマップは noremap（再帰的でない）、silent（コマンドの実行時に表示しない）を設定
local opts = { noremap = true, silent = true }

-- 挿入モードでの移動キーを設定
vim.keymap.set("i", "<C-h>", "<Left>")  -- Ctrl + h で左に移動
vim.keymap.set("i", "<C-j>", "<Down>")  -- Ctrl + j で下に移動
vim.keymap.set("i", "<C-k>", "<Up>")    -- Ctrl + k で上に移動
vim.keymap.set("i", "<C-l>", "<Right>") -- Ctrl + l で右に移動

-- ノーマルモードでのウィンドウ切り替え
vim.keymap.set("n", "<C-h>", "<C-w>h") -- Ctrl + h で左のウィンドウに切り替え
vim.keymap.set("n", "<C-j>", "<C-w>j") -- Ctrl + j で下のウィンドウに切り替え
vim.keymap.set("n", "<C-k>", "<C-w>k") -- Ctrl + k で上のウィンドウに切り替え
vim.keymap.set("n", "<C-l>", "<C-w>l") -- Ctrl + l で右のウィンドウに切り替え

-- ノーマルモードで <leader> + vt で垂直ターミナルを開く
vim.keymap.set("n", "<leader>vt", function()
  require("utils").VertTerm()
end, opts)

-- Alt + s でセッションを保存
vim.keymap.set("n", "<A-s>", ":mksession! mysession.vim<CR>", opts)

-- ロケーションリストを開く/閉じる
vim.keymap.set('n', '<leader>lo', "<Cmd>lopen<CR>", opts)  -- <leader> + lo でロケーションリストを開く
vim.keymap.set('n', '<leader>lc', "<Cmd>lclose<CR>", opts) -- <leader> + lc でロケーションリストを閉じる

-- クイックフィックスリストを開く/閉じる
vim.keymap.set('n', '<leader>co', "<Cmd>copen<CR>", opts)  -- <leader> + co でクイックフィックスリストを開く
vim.keymap.set('n', '<leader>cc', "<Cmd>cclose<CR>", opts) -- <leader> + cc でクイックフィックスリストを閉じる

-- クイックフィックスリストに診断情報を設定
vim.keymap.set('n', '<leader>cq', function()
  vim.diagnostic.setqflist()
end, opts)

-- 次の診断に移動
vim.keymap.set('n', '<leader>cn', function()
  vim.diagnostic.goto_next()
end, opts)

-- 前の診断に移動
vim.keymap.set('n', '<leader>cp', function()
  vim.diagnostic.goto_prev()
end, opts)

-- 通常モードでの '=' キーのマッピング: バッファ全体をフォーマット
vim.keymap.set('n', '=', function()
  vim.lsp.buf.format()
end, opts)

-- ビジュアルモードでの '=' キーのマッピング: 選択範囲のみをフォーマットし、カーソルを選択範囲の開始位置に戻す
vim.keymap.set('v', '=', function()
  -- 選択範囲のモードを取得（'v' か 'V'）
  local mode = vim.fn.visualmode()

  -- 選択範囲の開始行と列を取得
  local start_line = vim.fn.line("'<")
  local start_col = vim.fn.col("'<")

  -- 選択範囲の終了行と列を取得
  local end_line = vim.fn.line("'>")
  local end_col = vim.fn.col("'>")

  -- 行選択の場合、列を修正して行全体をフォーマット
  if mode == 'V' then
    start_col = 0
    end_col = 999 -- 行末までをフォーマット
  end

  -- フォーマットを実行
  vim.lsp.buf.format({
    async = true,
    range = {
      ["start"] = { line = start_line - 1, character = start_col - 1 },
      ["end"] = { line = end_line - 1, character = end_col },
    },
  })

  -- ESCで抜ける
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "n", true)
end, opts)
