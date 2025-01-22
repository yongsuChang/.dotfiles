return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
      local jar_pattern = mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"
      local launcher_jar = vim.fn.glob(jar_pattern)
      local config_path = mason_path .. "/config_linux"

      mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
      local project_root = require("jdtls.setup").find_root({ "gradlew", "pom.xml", "build.gradle", ".git" }) or vim.fn.getcwd()
      local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. vim.fn.fnamemodify(project_root, ":p:h:t")
      local build_classes = project_root .. "/build/classes/java/main"

      lspconfig.jdtls.setup({
        cmd = {
          "/usr/lib/jvm/java-17-openjdk-amd64/bin/java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xms1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens=java.base/java.util=ALL-UNNAMED",
          "--add-opens=java.base/java.lang=ALL-UNNAMED",
          "-jar", launcher_jar,
          "-configuration", config_path,
          "-data", workspace_dir,
          "-classpath", build_classes,
        },
        root_dir = project_root,
      })
    end,
  },
}

