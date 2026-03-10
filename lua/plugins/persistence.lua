-- persistence.nvim: 自動セッション管理
return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  keys = {
    { '<leader>qs', function() require('persistence').load() end, desc = 'セッション復元' },
    { '<leader>qS', function() require('persistence').select() end, desc = 'セッション選択' },
    { '<leader>ql', function() require('persistence').load({ last = true }) end, desc = '最後のセッション' },
    { '<leader>qd', function() require('persistence').stop() end, desc = 'セッション記録停止' },
  },
  opts = {},
}
