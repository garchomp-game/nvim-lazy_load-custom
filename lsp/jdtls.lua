-- jdtls: Java Language Server 設定（Lombokサポート含む）
local data_path = vim.fn.stdpath("data")
local workspace_path = data_path .. "/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local lombok_path = data_path .. "/mason/packages/jdtls/lombok.jar"

return {
  cmd = {
    'jdtls',
    '--jvm-arg=-javaagent:' .. lombok_path,
    '--jvm-arg=-Xbootclasspath/a:' .. lombok_path,
    '-data', workspace_path .. project_name,
  },
  filetypes = { 'java' },
  root_markers = { 'build.gradle', 'pom.xml', '.git', 'settings.gradle' },
  settings = {
    java = {
      configuration = {
        updateBuildConfiguration = "automatic",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name}=${member.value}, ${otherMembers}}",
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
      },
    },
  },
  init_options = {
    bundles = {},
    extendedClientCapabilities = {
      progressReportProvider = true,
      classFileContentsSupport = true,
    },
  },
  single_file_support = true,
}
