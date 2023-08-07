return {
  'windwp/nvim-autopairs',
  event = { 'CmdLineEnter', 'BufRead' },
  config = function()
    require('nvim-autopairs').setup {}
  end
}
