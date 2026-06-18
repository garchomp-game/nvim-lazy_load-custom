-- autocmd: ファイルタイプ別設定は ftplugin/ に移動済み
-- このファイルはグローバルな autocmd 用に使用

if vim.treesitter and vim.treesitter.start and not vim.g.user_treesitter_start_wrapped then
  vim.g.user_treesitter_start_wrapped = true
  local treesitter_start = vim.treesitter.start

  vim.treesitter.start = function(bufnr, lang)
    local ok, result = pcall(treesitter_start, bufnr, lang)
    if ok then
      return result
    end

    if tostring(result):find("Parser could not be created", 1, true) then
      return nil
    end

    error(result)
  end
end

local function parser_available(lang)
  if not (vim.treesitter and vim.treesitter.language and vim.treesitter.language.add) then
    return false
  end

  local ok, loaded = pcall(vim.treesitter.language.add, lang)
  return ok and loaded == true
end

local function parser_lang(bufnr)
  local ft = vim.bo[bufnr].filetype
  if ft == "" then
    return nil
  end

  local get_lang = vim.treesitter.language and vim.treesitter.language.get_lang
  if type(get_lang) == "function" then
    return get_lang(ft)
  end

  return ft
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("UserTreesitterStart", { clear = true }),
  callback = function(args)
    if not (vim.treesitter and vim.treesitter.start) then
      return
    end

    if vim.bo[args.buf].buftype ~= "" then
      return
    end

    local max_filesize = 512 * 1024 -- 512 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > max_filesize then
      return
    end

    local lang = parser_lang(args.buf)
    if not lang or not parser_available(lang) then
      return
    end

    vim.treesitter.start(args.buf, lang)
  end,
})
