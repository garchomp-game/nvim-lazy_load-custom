-- lsp.lua: LSP 全体の共通設定と server 一覧管理

local M = {}

local function config_root()
  local source = debug.getinfo(1, "S").source:gsub("^@", "")
  return vim.fs.dirname(vim.fs.dirname(vim.fs.dirname(source)))
end

function M.server_names()
  local names = {}
  local files = vim.fn.glob(config_root() .. "/lsp/*.lua", false, true)

  for _, file in ipairs(files) do
    local name = vim.fn.fnamemodify(file, ":t:r")
    if not name:match("^_") then
      names[#names + 1] = name
    end
  end

  table.sort(names)
  return names
end

local function setup_lsp_attach()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(ev)
      local function opts(desc)
        return { buffer = ev.buf, noremap = true, silent = true, desc = desc }
      end

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("定義へジャンプ"))
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("宣言へジャンプ"))
      vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts("型定義へジャンプ"))
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("実装へジャンプ"))
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("参照一覧"))
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("リネーム"))
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("コードアクション"))
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("ホバー情報"))
    end,
  })
end

local function setup_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok, blink = pcall(require, "blink.cmp")

  if ok and type(blink.get_lsp_capabilities) == "function" then
    capabilities = blink.get_lsp_capabilities(capabilities)
  end

  vim.lsp.config("*", {
    capabilities = capabilities,
  })
end

function M.setup()
  setup_capabilities()
  setup_lsp_attach()
end

return M
