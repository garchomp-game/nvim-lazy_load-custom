return {
  'windwp/nvim-autopairs',
  event = { 'CmdLineEnter', 'BufRead' },
  opts = function()
    require('nvim-autopairs').setup {}
  end
}
