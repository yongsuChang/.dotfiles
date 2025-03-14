return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      local root_pattern = require("lspconfig").util.root_pattern

      local excluded_filetypes = { "c", "cpp", "python" }  -- 제외할 파일 타입 목록

      -- Mason 설정
      mason_lspconfig.setup({
        ensure_installed = {
          -- "jdtls",       -- Java Language Server
          "ts_ls",    -- TypeScript Language Server
          "tailwindcss", -- TailwindCSS Language Server
        },
      })

      -- OS별 설정
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
      local os_name
      local java_path

      if vim.fn.has("mac") == 1 then
        os_name = "mac"
        java_path = "/opt/homebrew/Cellar/openjdk@21/21.0.6/bin/java"
      elseif vim.fn.has("unix") == 1 then
        os_name = "linux"
        java_path = "/usr/lib/jvm/java-21-openjdk-amd64/bin/java"
      else
        os_name = "win"
        java_path = "C:/Program Files/Java/jdk-21/bin/java.exe"  -- Windows 환경에 맞게 변경 필요
      end

      local config_path = mason_path .. "/config_" .. os_name

      local jar_pattern = mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"
      local launcher_jar = vim.fn.glob(jar_pattern)
      local project_root = require("jdtls.setup").find_root({ "gradlew", "pom.xml", "build.gradle", ".git" }) or vim.fn.getcwd()
      local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. vim.fn.fnamemodify(project_root, ":p:h:t")
      local build_classes = project_root .. "/build/classes/java/main"

      lspconfig.jdtls.setup({
        cmd = {
          java_path,
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xms1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens=java.base/java.util=ALL-UNNAMED",
          "--add-opens=java.base/java.lang=ALL-UNNAMED",
          "-javaagent:" .. vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/lombok.jar"),
          "-jar", launcher_jar,
          "-configuration", config_path,
          "-data", workspace_dir,
        },
        root_dir = lspconfig.util.root_pattern("pom.xml", "gradlew", "build.gradle", ".git"),
      })

      -- TypeScript 설정
      lspconfig.ts_ls.setup({
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })

      -- TailwindCSS 설정
      lspconfig.tailwindcss.setup({
        root_dir = root_pattern("tailwind.config.js", "package.json", ".git"),
        settings = {
          tailwindCSS = {
            experimental = {
              configFile = vim.loop.cwd() .. "/tailwind.config.js",
            },
          },
        },
        filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
      })

      -- LTeX 설정
      -- lspconfig.ltex.setup({
      --   filetypes = {
      --     "plaintext", "markdown", "tex", "gitcommit", "org",
      --     "java", "javascript", "javascriptreact", "typescript", "typescriptreact",
      --     "html", "css", "lua", "vim", "sh", "json", "yaml"
      --   },
      --   on_attach = function(client, bufnr)
      --     local ft = vim.bo.filetype
      --     for _, excluded in ipairs(excluded_filetypes) do
      --       if ft == excluded then
      --         client.stop()
      --         return
      --       end
      --     end
      --   end,
      --   settings = {
      --     ltex = {
      --       language = "en-US",
      --       dictionary = {
      --         ["en-US"] = {},
      --       },
      --     },
      --   },
      -- })
    end,
  },
}

