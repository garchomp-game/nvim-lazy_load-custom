return {
  'Sol-Ponz/plantuml-previewer.nvim',
  event = "VeryLazy",
  opts = {
    plantuml_jar = vim.env.HOME .. "/plantuml.jar",
    java_command = "/usr/bin/java",
  },
}
