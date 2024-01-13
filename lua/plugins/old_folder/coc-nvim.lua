return {
  'neoclide/coc.nvim',
  event = { 'CmdLineEnter', 'BufRead' },
  config = function()
    -- coc.nvim のグローバル拡張の設定
    vim.g.coc_global_extensions = {
      'coc-tsserver',
      'coc-eslint',
      'coc-prettier',
      'coc-git',
      'coc-fzf-preview',
      'coc-lists'
    }

    -- インサートモードでの補完トリガー
    vim.api.nvim_set_keymap('i', '<C-Space>', 'coc#refresh()', { noremap = true, expr = true })

    -- ドキュメント表示
    vim.api.nvim_set_keymap('n', 'K', '<Cmd>call v:lua.show_documentation()<CR>', { noremap = true, silent = true })

    -- TypeScriptの設定
    vim.cmd [[
      augroup coc_ts
        autocmd!
        autocmd FileType typescript,typescriptreact call v:lua.coc_typescript_settings()
      augroup END
    ]]

    -- カスタム関数
    function _G.coc_typescript_settings()
      vim.api.nvim_buf_set_keymap(0, 'n', '<Plug>(lsp)f', ':<C-u>CocCommand eslint.executeAutofix<CR>:CocCommand prettier.formatFile<CR>', { noremap = true, silent = true })
    end

    function _G.show_documentation()
      local filetype = vim.bo.filetype
      if filetype == 'vim' or filetype == 'help' then
        vim.api.nvim_exec('h ' .. vim.fn.expand('<cword>'), false)
      elseif vim.fn['coc#rpc#ready']() then
        vim.fn.CocActionAsync('doHover')
      end
    end
  end,
}
