-- trouble.nvim: 診断・参照リストのモダンUI
-- QuickFix/LocList の上位互換
return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = '全体の診断' },
    { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'バッファ内診断' },
    { '<leader>xl', '<cmd>Trouble loclist toggle<cr>', desc = 'ロケーションリスト' },
    { '<leader>xq', '<cmd>Trouble qflist toggle<cr>', desc = 'クイックフィックス' },
  },
  opts = {},
}
