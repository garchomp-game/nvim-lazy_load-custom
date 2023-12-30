return {
  'Sol-Ponz/plantuml-previewer.nvim',
  event = { 'CmdLineEnter', 'BufRead' },
  opts = function()
    require("plantuml-previewer").setup {
      plantuml_jar = "/home/garchomp-game/plantuml.jar",
      java_command = "/usr/bin/java",
    }
  end,
}
