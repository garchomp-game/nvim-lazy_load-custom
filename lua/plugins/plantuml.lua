return {
  'Sol-Ponz/plantuml-previewer.nvim',
  event = { 'CmdLineEnter' },
  opts = function()
    local home = vim.env.HOME
    require("plantuml-previewer").setup {
      plantuml_jar = home .. "/plantuml.jar",
      java_command = "/usr/bin/java",
    }
  end,
}
