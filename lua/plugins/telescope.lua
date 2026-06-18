return {
  'nvim-telescope/telescope.nvim',
  event = "VeryLazy",
  keys = {
    { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'ファイル検索' },
    { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = '全文検索' },
    { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = 'buffer検索' },
    { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'help検索' },
    { '<leader>fr', function() require('telescope.builtin').oldfiles() end, desc = '最近のファイル' },
    { '<leader>fw', function() require('telescope.builtin').grep_string() end, desc = 'カーソル下の単語を検索' },
    { '<leader>f/', function() require('telescope.builtin').current_buffer_fuzzy_find() end, desc = '現在buffer内を検索' },
    { '<leader>fk', function() require('telescope.builtin').keymaps() end, desc = 'キーマップ検索' },
    { '<leader>fc', function() require('telescope.builtin').commands() end, desc = 'コマンド検索' },
    { '<leader>fd', function() require('telescope.builtin').diagnostics() end, desc = '診断検索' },
  },
  opts = {
    defaults = {
      -- Default configuration for telescope goes here:
      -- config_key = value,
      mappings = {
        i = {
          -- map actions.which_key to <C-h> (default: <C-/>)
          -- actions.which_key shows the mappings for your picker,
          -- e.g. git_{create, delete, ...}_branch for the git_branches picker
          ["<C-h>"] = "which_key"
        }
      }
    },
    pickers = {
      -- Default configuration for builtin pickers goes here:
      -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- Now the picker_config_key will be applied every time you call this
      -- builtin picker
    },
    extensions = {
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
    }
  }
}
