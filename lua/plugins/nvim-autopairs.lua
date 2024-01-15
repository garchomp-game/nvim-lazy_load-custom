return {
  'windwp/nvim-autopairs',
  event = { 'BufRead' },
  opts = function()
    require('nvim-autopairs').setup {}
  end
}
