return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  dependencies = {
    'nvim-treesitter/playground',
  },
  config = function()
    ---@class MyParserConfig
    ---@field blade table<string, any>
    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

    parser_config.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = {"src/parser.c"},
        branch = "main",
      },
      filetype = "blade"
    }
    require'nvim-treesitter.configs'.setup {
      -- A list of parser names, or "all" (the four listed parsers should always be installed)
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      },
      ensure_installed = {
        "vim",
        "vimdoc",
        "java",
        "php",
        "vue",
        "lua",
        "javascript",
        "typescript",
        "markdown",
        "markdown_inline",
        "blade",
        "html",
        "css",
        "scss",
        "pug",
      },
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = {
        enable = true,
      },
      modules = {
        -- モジュール設定...
      },
      sync_install = false,  -- 同期インストールを無効にする
      ignore_install = { },  -- 特定の言語のインストールを無視
      auto_install = true,  -- 自動インストールを有効にする
    }
  end,
}
