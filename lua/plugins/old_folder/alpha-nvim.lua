return {
  'goolord/alpha-nvim',
  lazy = false,
  config = function ()
    require'alpha'.setup(require'alpha.themes.dashboard'.config)
  end
};
