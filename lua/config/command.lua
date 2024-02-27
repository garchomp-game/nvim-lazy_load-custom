vim.api.nvim_create_user_command("CopyMessage", function()
	vim.cmd("redir @+ | messages | redir END")
end, {})

-- 行末のスペースを消す
vim.api.nvim_create_user_command("TrimTrailingSpace", function(opts)
    local start_line = opts.line1
    local end_line = opts.line2
    -- 半角スペース、全角スペース、タブ文字を含む末尾の空白文字をマッチするように正規表現を修正
    local command = start_line .. "," .. end_line .. "s/[\\s\\u3000]+\\+$//ge"
    vim.cmd(command)
    vim.cmd("noh")
end, { range = true })

-- utilsモジュールをインポート
local utils = require("utils")

-- カスタムコマンドを作成
vim.api.nvim_create_user_command("VertTerm", function(opts)
	local size = opts.args ~= "" and opts.args or "95"
	utils.VertTerm(size)
end, {
	nargs = "?",
	complete = function()
		return { "size" }
	end,
})
