return {
  'Sol-Ponz/plantuml-previewer.nvim',
  event = { 'CmdLineEnter' },
  opts = {
    plantuml_jar = vim.env.HOME .. "/plantuml.jar",
    java_command = "/usr/bin/java",
  },
}
