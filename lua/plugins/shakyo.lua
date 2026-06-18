return {
  'NI57721/vim-shakyo',
  keys = {
    { '<leader>sr', '<Plug>(shakyo-run)', desc = '写経開始', remap = true },
    { '<leader>sq', '<Plug>(shakyo-quit)', desc = '写経終了', remap = true },
    { '<leader>sc', '<Plug>(shakyo-clue)', desc = '写経ヒント', remap = true },
  },
  config = function()
    -- カスタムハイライトグループの宣言
    local shakyoCompletedHighlight = "ShakyoCompleted"
    local shakyoWrongHighlight = "ShakyoWrong"

    -- カスタムハイライトグループの設定
    vim.api.nvim_set_hl(0, shakyoCompletedHighlight, { fg = '#ffffff', bg = '#ffff00' })
    vim.api.nvim_set_hl(0, shakyoWrongHighlight, { fg = '#ffffff', bg = '#ff0000' })

    -- shakyoプラグインのハイライト設定をカスタムグループに変更
    vim.fn['shakyo#config']({
      highlight = {
        completed = shakyoCompletedHighlight,
        wrong = shakyoWrongHighlight
      }
    })
  end
}
