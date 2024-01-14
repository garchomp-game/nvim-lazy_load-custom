return {
  'terryma/vim-multiple-cursors',
  event = { 'CmdLineEnter', 'BufRead' },
  config = function()
    vim.g.multi_cursor_use_default_mapping = 0
    vim.g.multi_cursor_start_word_key = '<C-b>'
    vim.g.multi_cursor_select_all_word_key = '<A-b>'
    vim.g.multi_cursor_start_key = 'g<C-b>'
    vim.g.multi_cursor_select_all_key = 'g<A-b>'
    vim.g.multi_cursor_next_key = '<C-b>'
    vim.g.multi_cursor_prev_key = '<C-p>'
    vim.g.multi_cursor_skip_key = '<C-x>'
    vim.g.multi_cursor_quit_key = '<Esc>'
  end
}
