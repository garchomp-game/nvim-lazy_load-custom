return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,  -- プラグインを遅延読み込みしない設定
  build = ':TSUpdate',  -- アップデート時にパーサーも更新
  config = function()
    -- Bladeテンプレートのカスタムパーサーを登録（新API）
    vim.api.nvim_create_autocmd('User', {
      pattern = 'TSUpdate',
      callback = function()
        require('nvim-treesitter.parsers').blade = {
          install_info = {
            url = "https://github.com/EmranMR/tree-sitter-blade",
            files = { "src/parser.c" },
            branch = "main",
          },
        }
      end,
    })
    vim.treesitter.language.register('blade', 'blade')

    -- パーサーのインストール（新APIでは install() を使う）
    require('nvim-treesitter').install({
      "vim",              -- Vimスクリプト
      "vimdoc",           -- Vimのドキュメントファイル
      "java",             -- Java
      "php",              -- PHP
      "vue",              -- Vue.js
      "lua",              -- Lua
      "javascript",       -- JavaScript
      "typescript",       -- TypeScript
      "markdown",         -- Markdown
      "markdown_inline",  -- Markdownのインライン要素
      "html",             -- HTML
      "css",              -- CSS
      "scss",             -- SCSS
      "pug",              -- Pug
      "bash",             -- Bash
    })

    -- ハイライトは Neovim 組み込み機能を使用
    -- 大きなファイルでは無効にするため FileType autocmd で制御
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
        if ok and stats and stats.size > max_filesize then
          return
        end
        -- パーサーが利用可能ならハイライトを有効化
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
