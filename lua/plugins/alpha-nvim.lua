-- lua/plugins/alpha-nvim.lua

return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  dependencies = { 'kyazdani42/nvim-web-devicons' }, -- アイコン表示用
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    -- カスタムヘッダーの設定（ドラゴンのASCIIアート）
dashboard.section.header.val = {
  [[                ______________]],
  [[       ,===:'.,            `-._]],
  [[            `:.`---.__         `-._]],
  [[              `:.     `--.         `.]],
  [[                \.        `.         `]],
  [[        (,,(,    \.         `.   ____,-`.,]],
  [[     (,'     `/   \.   ,--.___`.]],
  [[ ,  ,'  ,--.  `,   \.;'         `]],
  [[  `{D, {    \  :    \;]],
  [[    V,,'    /  /    //]],
  [[    j;;    /  ,' ,-//.    ,---.      ,]],
  [[    \;'   /  ,' /  _  \  /  _  \   ,' /]],
  [[          \   `'  / \  `'  / \  `.'  /]],
  [[           `.___,'   `.__,'   `.__,'  ]]
}

    -- カスタムボタンの設定
    dashboard.section.buttons.val = {
      dashboard.button("e", "  新規ファイル", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "󰊄  最近のファイル", ":Telescope oldfiles<CR>"),
      dashboard.button("g", "󰊢  Gitブランチ", ":Neogit<CR>"),
      dashboard.button("p", "󰏭  プロジェクト検索", ":Telescope projects<CR>"),
      dashboard.button("r", "󰜱  最近の検索", ":Telescope live_grep<CR>"),
      dashboard.button("s", "󰤄  設定", ":e ~/.config/nvim/init.lua<CR>"),
      dashboard.button("t", "󱈙  トグルターミナル", ":ToggleTerm<CR>"), -- ToggleTermへのショートカット
      dashboard.button("q", "  Neovimを終了", ":qa<CR>"),
    }

    -- ランダムなフッターの設定
    local footer = {
      "Never stop learning 🚀",
      "Code is poetry 💻",
      "Stay hungry, stay foolish 🐺",
      "Happy Hacking 🛠️",
      "Embrace the challenges 💪",
    }
    math.randomseed(os.time())
    dashboard.section.footer.val = footer[math.random(#footer)]

    -- 引用セクションの追加
    local quotes = {
      "“Code is like humor. When you have to explain it, it’s bad.” – Cory House",
      "“Fix the cause, not the symptom.” – Steve Maraboli",
      "“Optimism is an occupational hazard of programming: feedback is the treatment.” – Kent Beck",
    }

    dashboard.section.quotes = {
      type = "text",
      val = {
        quotes[math.random(#quotes)],
      },
      opts = {
        position = "center",
        hl = "Constant",
      },
    }

    -- レイアウトの再定義
    dashboard.opts.layout = {
      { type = "padding", val = 8 }, -- ヘッダーの上の余白
      dashboard.section.header,
      { type = "padding", val = 1 }, -- 引用セクションの上の余白
      dashboard.section.quotes,
      { type = "padding", val = 1 }, -- ボタンの上の余白
      dashboard.section.buttons,
      { type = "padding", val = 2 }, -- ボタンの下の余白
      dashboard.section.footer,
    }

    -- セクションのスタイル設定
    dashboard.section.header.opts = {
      position = "center",
      hl = "Statement", -- ヘッダーのハイライトグループを変更
    }

    dashboard.section.buttons.opts = {
      position = "center",
      hl = "String", -- ボタンのテキストカラーを変更
      spacing = 1,
      padding = 1,
    }

    dashboard.section.footer.opts = {
      position = "center",
      hl = "Type", -- フッターのハイライトグループを変更
    }

    -- `alpha.nvim` のセットアップ
    alpha.setup(dashboard.opts)

    -- Neovim の起動時に `alpha.nvim` がフォーカスされるようにする
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      callback = function()
        -- 必要に応じて追加設定
      end,
    })
  end
};
