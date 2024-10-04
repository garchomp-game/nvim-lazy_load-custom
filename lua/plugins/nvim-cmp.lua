-- nvim-cmpプラグインの設定
return {
  'hrsh7th/nvim-cmp',
  event = "VeryLazy",  -- プラグインを遅延読み込みするイベントを指定
  dependencies = {
    'williamboman/mason-lspconfig.nvim',  -- LSPの設定と統合するためのプラグイン
    'williamboman/mason.nvim',            -- LSPとDapのためのインストーラ
    'hrsh7th/cmp-nvim-lsp',               -- LSPの補完ソースを追加
    'hrsh7th/cmp-buffer',                 -- バッファ内の単語を補完
    'hrsh7th/cmp-path',                   -- ファイルパスの補完
    'hrsh7th/cmp-cmdline',                -- コマンドラインの補完
    'L3MON4D3/LuaSnip',                   -- スニペットエンジン
    'saadparwaiz1/cmp_luasnip',           -- LuaSnipとの統合
    'hrsh7th/cmp-nvim-lua',               -- NeovimのLua APIの補完
    'f3fora/cmp-spell',                   -- スペルチェックの補完
    'hrsh7th/cmp-emoji',                  -- 絵文字の補完
  },
  config = function()
    -- カーソルの前に単語があるか確認する関数
    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
                :sub(col, col):match("%s") == nil
    end

    -- nvim-cmpとLuaSnipを読み込み
    local cmp = require'cmp'
    local luasnip = require('luasnip')

    -- nvim-cmpのセットアップ
    cmp.setup({
      snippet = {
        -- スニペットエンジンの設定
        expand = function(args)
          luasnip.lsp_expand(args.body) -- LuaSnipを使用してスニペットを展開
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),  -- 補完ウィンドウに枠線を追加
        documentation = cmp.config.window.bordered(), -- ドキュメントウィンドウに枠線を追加
      },
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()  -- 補完メニューが表示されている場合、次の項目を選択
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()  -- スニペットを展開するか、次のジャンプポイントに移動
          elseif has_words_before() then
            cmp.complete()  -- 補完を開始
          else
            fallback()  -- 他の操作を実行
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()  -- 補完メニューが表示されている場合、前の項目を選択
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)  -- スニペット内を逆方向にジャンプ
          else
            fallback()  -- 他の操作を実行
          end
        end, { "i", "s" }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),  -- ドキュメントを上にスクロール
        ['<C-f>'] = cmp.mapping.scroll_docs(4),   -- ドキュメントを下にスクロール
        ['<C-Space>'] = cmp.mapping.complete(),   -- 手動で補完を開始
        ['<C-e>'] = cmp.mapping.abort(),          -- 補完をキャンセル
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- 現在選択されている項目を確定
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },  -- LSPからの補完ソース
        { name = 'path' },      -- ファイルパスの補完
        { name = 'luasnip' },   -- LuaSnipからの補完
        { name = 'nvim_lua' },  -- NeovimのLua API補完
        { name = 'spell' },     -- スペルチェック補完
        { name = 'emoji' },     -- 絵文字補完
      }, {
          { name = 'buffer' },  -- バッファ内の単語を補完
        }
      ),
      completion = {
        -- 自動補完のトリガー条件をカスタマイズ
        autocomplete = {
          cmp.TriggerEvent.TextChanged,  -- テキストが変更されたときに自動で補完を開始
        },
      },
    })

    -- 特定のファイルタイプの設定（Gitのコミットメッセージ用）
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources(
        {
          { name = 'cmp_git' }, -- Git関連の補完ソース
        },
        {
          { name = 'buffer' },  -- バッファ内の単語を補完
        }
      )
    })

    -- `/`と`?`のコマンドライン用の設定
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'buffer' }  -- バッファ内の単語を補完
      })
    })

    -- `:`のコマンドライン用の設定
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },   -- ファイルパスの補完
      }, {
          { name = 'cmdline' }  -- コマンドラインの補完
        })
    })
  end,
}
