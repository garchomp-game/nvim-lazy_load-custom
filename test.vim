autocmd BufRead * lua vim.notify('BufRead ' .. vim.fn.expand('%'))
autocmd BufEnter * lua vim.notify('BufEnter ' .. vim.fn.expand('%'))
autocmd WinEnter * lua vim.notify('WinEnter ' .. vim.fn.winnr())
