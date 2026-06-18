return {
  -- amongst your other plugins
  'akinsho/toggleterm.nvim',
  event = "VeryLazy",
  version = "*",
  cmd = {
    "ToggleTerm",
    "ToggleTermToggleAll",
    "TermExec",
  },
  keys = {
    [[<c-\>]],
    { '<leader>tt', '<cmd>ToggleTerm<cr>', desc = 'ターミナルを開閉' },
    { '<leader>th', '<cmd>ToggleTerm direction=horizontal<cr>', desc = '水平ターミナルを開閉' },
    { '<leader>tv', '<cmd>ToggleTerm direction=vertical<cr>', desc = '垂直ターミナルを開閉' },
    { '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', desc = 'フロートターミナルを開閉' },
    { '<leader>ta', '<cmd>ToggleTermToggleAll<cr>', desc = '全ターミナルを開閉' },
  },
  opts = {
    open_mapping = [[<c-\>]],
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    vim.api.nvim_create_autocmd('TermOpen', {
      group = vim.api.nvim_create_augroup('UserTerminalKeymaps', { clear = true }),
      pattern = 'term://*',
      callback = function(args)
        local map_opts = { buffer = args.buf, silent = true }
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], map_opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], map_opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], map_opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], map_opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], map_opts)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], map_opts)
        vim.keymap.set('t', '<C-p>', [[<Up>]], map_opts)
        vim.keymap.set('t', '<C-n>', [[<Down>]], map_opts)
      end,
    })
  end,
}
