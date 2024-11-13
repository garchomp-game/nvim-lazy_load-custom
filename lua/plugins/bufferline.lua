-- lua/plugins/bufferline.lua

return {
  'akinsho/bufferline.nvim',
  event = "VeryLazy",
  dependencies = {
    'nvim-tree/nvim-web-devicons' -- アイコン表示のための依存プラグイン
  },
  opts = {
    options = {
      -- デフォルトのバッファアイコン表示オプションは削除
      -- show_buffer_default_icon = true,

      -- アイコン取得関数の設定
      get_element_icon = function(buf)
        -- nvim-web-devicons を使用してアイコンを取得
        local icon, hl = require('nvim-web-devicons').get_icon(buf.name, buf.extension, { default = false })
        return icon, hl
      end,

      separator_style = "slant",

      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = ""
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " " or " "
          s = s .. sym .. n .. " "
        end
        return s
      end,

      enforce_regular_tabs = false,
      scroll_behavior = "cycle",
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = false,
      truncate_names = true,
      -- show_buffer_default_icon = true, -- 非推奨のオプションを削除
      modified_icon = "●",
      allow_drag = true,
      always_show_bufferline = true,
      themable = true,
      numbers = "ordinal", -- バッファ番号を表示（オプション）
    },
  },
}
