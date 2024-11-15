-- オプションを設定: キーマップは noremap（再帰的でない）、silent（コマンドの実行時に表示しない）を設定
local opts = { noremap = true, silent = true }

-- 挿入モードでの移動キーを設定
vim.keymap.set("i", "<c-h>", "<left>")  -- ctrl + h で左に移動
vim.keymap.set("i", "<c-j>", "<down>")  -- ctrl + j で下に移動
vim.keymap.set("i", "<c-k>", "<up>")    -- ctrl + k で上に移動
vim.keymap.set("i", "<c-l>", "<right>") -- ctrl + l で右に移動

-- ノーマルモードでのウィンドウ切り替え
vim.keymap.set("n", "<c-h>", "<c-w>h") -- ctrl + h で左のウィンドウに切り替え
vim.keymap.set("n", "<c-j>", "<c-w>j") -- ctrl + j で下のウィンドウに切り替え
vim.keymap.set("n", "<c-k>", "<c-w>k") -- ctrl + k で上のウィンドウに切り替え
vim.keymap.set("n", "<c-l>", "<c-w>l") -- ctrl + l で右のウィンドウに切り替え

-- ノーマルモードで <leader> + vt で垂直ターミナルを開く
vim.keymap.set("n", "<leader>vt", function()
  require("utils").vertterm()
end, opts)

-- alt + s でセッションを保存
vim.keymap.set("n", "<a-s>", ":mksession! mysession.vim<cr>", opts)

-- ロケーションリストを開く/閉じる
vim.keymap.set('n', '<leader>lo', "<cmd>lopen<cr>", opts)  -- <leader> + lo でロケーションリストを開く
vim.keymap.set('n', '<leader>lc', "<cmd>lclose<cr>", opts) -- <leader> + lc でロケーションリストを閉じる

-- クイックフィックスリストを開く/閉じる
vim.keymap.set('n', '<leader>co', "<cmd>copen<cr>", opts)  -- <leader> + co でクイックフィックスリストを開く
vim.keymap.set('n', '<leader>cc', "<cmd>cclose<cr>", opts) -- <leader> + cc でクイックフィックスリストを閉じる

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
  -- フォーマットを実行（選択範囲が自動的に適用される）
  vim.lsp.buf.format({ async = true })

  -- ビジュアルモードを終了
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
end, opts)


vim.api.nvim_set_keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F10>", ":lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F11>", ":lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F12>", ":lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>dr", ":lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>dl", ":lua require'dap'.run_last()<CR>", { noremap = true, silent = true })
