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

-- 通常モード・ビジュアルモードでの '=' キーのフォーマットは
-- conform.nvim の keys 設定で管理しているためここからは削除

-- LSPアタッチ時のキーマップ設定
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(ev)
    local opts_with_buf = function(desc)
      return { buffer = ev.buf, noremap = true, silent = true, desc = desc }
    end
    -- 定義ジャンプ
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts_with_buf('定義へジャンプ'))
    -- 宣言ジャンプ
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts_with_buf('宣言へジャンプ'))
    -- 型定義ジャンプ
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts_with_buf('型定義へジャンプ'))
    -- 実装へジャンプ
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts_with_buf('実装へジャンプ'))
    -- 参照一覧
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts_with_buf('参照一覧'))
    -- リネーム
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts_with_buf('リネーム'))
    -- コードアクション
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts_with_buf('コードアクション'))
    -- ホバー情報
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts_with_buf('ホバー情報'))
  end,
})

-- DAP キーマップは lua/plugins/nvim-dap.lua で管理

