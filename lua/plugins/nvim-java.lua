return {
  'nvim-java/nvim-java',
  event = "VeryLazy",
  config = function()
    require('lspconfig').jdtls.setup({
      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-17",
                path = "/home/garchomp-game/.sdkman/candidates/java/current",
                default = true,
              }
            }
          }
        }
      }
    })
  end
}
