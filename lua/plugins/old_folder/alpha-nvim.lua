return {
  'goolord/alpha-nvim',
  event = "VeryLazy",
  config = function ()
    require'alpha'.setup(require'alpha.themes.dashboard'.config)
  end
};
