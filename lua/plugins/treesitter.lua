return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'CmdLineEnter', 'BufRead' },
  opts = function()

    require'nvim-treesitter.configs'.setup {
      -- A list of parser names, or "all" (the four listed parsers should always be installed)
      ensure_installed = { 
        "lua", 
        "vim", 
        "java",
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
