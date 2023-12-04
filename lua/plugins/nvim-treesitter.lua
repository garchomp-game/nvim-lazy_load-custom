return {
  {
    'nvim-treesitter/playground',
    event = { 'CmdLineEnter', 'BufRead' },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'CmdLineEnter', 'BufRead' },
    opts = function()

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
          "java",
          "php",
          "vue",
          "lua",
          "javascript",
          "typescript",
          "markdown",
          "markdown_inline",
        },

        highlight = {
          enable = true,
          use_languagetree = true,
        },

        indent = {
          enable = true,
        },
      }
    end,
  }
}
