return {
  'nvim-neo-tree/neo-tree.nvim',
  event = { 'CmdLineEnter', 'BufRead' },
  keys = {'<C-n>'},
  config = function()
    vim.api.nvim_set_keymap(
      'n','<C-n>',
      ':Neotree toggle<CR>',
      { noremap = true, silent = true }
    )
  end,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    'folke/tokyonight.nvim',
  },
  opts = function()
    require('neo-tree').setup({
      -- 他の設定...

      filesystem = {
        filtered_items = {
          -- 他の設定...
        },
        follow_current_file = {
          enabled = true,  -- 以前の `follow_current_file = true` に相当
          -- 他の追加オプション...
        },
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,  -- ファイル変更を監視
      },

      window = {
        -- 他の設定...
      },

      default_component_configs = {
        -- 他の設定...

        modified = {
          symbol = "●",
          highlight = "NeoTreeModified",  -- このハイライトグループを設定
        },
      },

      -- 他の設定...
    })

    -- 変更済みファイルのハイライト設定
    vim.api.nvim_set_hl(0, "NeoTreeModified", { fg = "#61afef" })
  end
}
