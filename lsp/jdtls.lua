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
    bundles = (function()
      local mason_path = vim.fn.stdpath('data') .. '/mason/packages'
      local bundles = {}
      -- java-debug-adapter
      local debug_jar = vim.fn.glob(
        mason_path .. '/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar',
        true
      )
      if debug_jar ~= '' then
        vim.list_extend(bundles, { debug_jar })
      end
      -- java-test
      local test_jars = vim.fn.glob(
        mason_path .. '/java-test/extension/server/*.jar',
        true, true
      )
      if test_jars then
        vim.list_extend(bundles, test_jars)
      end
      return bundles
    end)(),
    extendedClientCapabilities = {
      progressReportProvider = true,
      classFileContentsSupport = true,
    },
  },
  single_file_support = true,
}
