return {
  {
    'Exafunction/codeium.vim',
    event = "VeryLazy",
    keys = {
      '<C-g>',
      '<c-;>',
      '<c-,>',
      '<c-x>',
      '<c-.>',
      '<c-y>',
      '<c-q>',
      '<c-s>',
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set(
        'i',
        '<C-g>',
        function ()
          return vim.fn['codeium#Accept']()
        end,
        { expr = true, silent = true }
      )
      vim.keymap.set(
        'i',
        '<c-;>',
        function()
          return vim.fn['codeium#CycleCompletions'](1)
        end,
        { expr = true, silent = true }
      )
      vim.keymap.set(
        'i',
        '<c-,>',
        function()
          return vim.fn['codeium#CycleCompletions'](-1)
        end,
        { expr = true, silent = true }
      )
      vim.keymap.set(
        'i',
        '<c-x>',
        function()
          return vim.fn['codeium#Clear']()
        end,
        { expr = true, silent = true }
      )
      vim.keymap.set(
        'i',
        '<c-.>',
        function()
          return vim.fn['codeium#Complete']()
        end,
        { expr = true, silent = true }
      )
      vim.keymap.set(
        'i',
        '<c-y>',
        function()
          return vim.fn['codeium#YankKey']()
        end,
        { expr = true, silent = true }
      )
      vim.keymap.set(
        'i',
        '<c-q>',
        function()
          return vim.fn['codeium#Dismiss']()
        end,
        { expr = true, silent = true }
      )
      vim.keymap.set(
        'i',
        '<c-s>',
        function()
          return vim.fn['codeium#Select']()
        end,
        { expr = true, silent = true }
      )
    end
  }
}
