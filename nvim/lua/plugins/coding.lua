return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jdtls = {
          cmd = { "jdtls" }, -- Ensure 'jdtls' is in your PATH or provide the absolute path
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(".git", "pom.xml", "build.gradle")(fname)
              or vim.loop.os_homedir()
          end,
          settings = {
            java = {
              inlayHints = {
                parameterNames = true,
              },
            },
          },
        },
        clangd = {}, -- Clangd server configuration
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "jdtls", -- Java Language Server
        "java-debug-adapter", -- Java Debug Adapter
        "java-test", -- Java Test Adapter
        "clangd", -- C/C++ Language Server
        "codelldb", -- Debug Adapter for C/C++
      })
    end,
  },
}
