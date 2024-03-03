return {
  'numtostr/comment.nvim',
  event = "VeryLazy",
  config = true
}

-- 以下の書き方もいいなーと思って検討中。
--
-- local M = {}
--
-- table.insert(M, 'numtostr/comment.nvim')
--
-- M.event = "VeryLazy"
-- M.config = true
--
-- return M
