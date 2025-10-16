return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- util만 별도 모듈에서 사용 (lspconfig 본체 require 불필요)
      local util = require("lspconfig.util")
      local root_pattern = util.root_pattern

      local mason_lspconfig = require("mason-lspconfig")

      -- 필요하면 공통 디폴트 옵션을 한 번에 지정
      -- 모든 LSP에 공통 적용됨
      vim.lsp.config("*", {
        -- on_attach = function(client, bufnr) ... end,
        -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- Mason ensure_installed
      mason_lspconfig.setup({
        ensure_installed = {
          -- "jdtls",
          "ts_ls",
          "tailwindcss",
        },
      })

      ----------------------------------------------------------------
      -- OS / jdtls 경로 설정
      ----------------------------------------------------------------
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
      local os_name, java_path

      if vim.fn.has("mac") == 1 then
        os_name = "mac"
        java_path = "/opt/homebrew/Cellar/openjdk@21/21.0.6/bin/java"
      elseif vim.fn.has("unix") == 1 then
        os_name = "linux"
        java_path = "/usr/lib/jvm/java-21-openjdk-amd64/bin/java"
      else
        os_name = "win"
        java_path = "C:/Program Files/Java/jdk-21/bin/java.exe"
      end

      local config_path = mason_path .. "/config_" .. os_name
      local jar_pattern = mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"
      local launcher_jar = vim.fn.glob(jar_pattern)

      local jdtls_root = require("jdtls.setup").find_root({ "gradlew", "pom.xml", "build.gradle", ".git" }) or vim.fn.getcwd()
      local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. vim.fn.fnamemodify(jdtls_root, ":p:h:t")

      ----------------------------------------------------------------
      -- 각 서버별 구성: vim.lsp.config + vim.lsp.enable
      ----------------------------------------------------------------

      -- Java (jdtls)
      vim.lsp.config("jdtls", {
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
        root_dir = util.root_pattern("pom.xml", "gradlew", "build.gradle", ".git"),
      })
      vim.lsp.enable("jdtls")

      -- TypeScript (ts_ls)
      vim.lsp.config("ts_ls", {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })
      vim.lsp.enable("ts_ls")

      -- Tailwind CSS
      vim.lsp.config("tailwindcss", {
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
      vim.lsp.enable("tailwindcss")

      ----------------------------------------------------------------
      -- LTeX (필요 시 주석 해제)
      ----------------------------------------------------------------
      -- local excluded_filetypes = { "c", "cpp", "python" }
      -- vim.lsp.config("ltex", {
      --   filetypes = {
      --     "plaintext", "markdown", "tex", "gitcommit", "org",
      --     "java", "javascript", "javascriptreact", "typescript", "typescriptreact",
      --     "html", "css", "lua", "vim", "sh", "json", "yaml",
      --   },
      --   on_attach = function(client, bufnr)
      --     local ft = vim.bo.filetype
      --     for _, ex in ipairs(excluded_filetypes) do
      --       if ft == ex then
      --         client.stop()
      --         return
      --       end
      --     end
      --   end,
      --   settings = {
      --     ltex = {
      --       language = "en-US",
      --       dictionary = { ["en-US"] = {} },
      --     },
      --   },
      -- })
      -- vim.lsp.enable("ltex")
    end,
  },
}

