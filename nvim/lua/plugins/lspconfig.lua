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
          "jdtls",       -- Java Language Server
          "ts_ls",    -- TypeScript Language Server
          "tailwindcss", -- TailwindCSS Language Server
        },
      })

      -- Java 설정
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
      local jar_pattern = mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"
      local launcher_jar = vim.fn.glob(jar_pattern)
      local config_path = mason_path .. "/config_linux"
      local project_root = require("jdtls.setup").find_root({ "gradlew", "pom.xml", "build.gradle", ".git" }) or vim.fn.getcwd()
      local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. vim.fn.fnamemodify(project_root, ":p:h:t")
      local build_classes = project_root .. "/build/classes/java/main"
      lspconfig.jdtls.setup({
        cmd = {
          "/usr/lib/jvm/java-21-openjdk-amd64/bin/java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xms1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens=java.base/java.util=ALL-UNNAMED",
          "--add-opens=java.base/java.lang=ALL-UNNAMED",
          "-javaagent:/home/yongsu/.local/share/nvim/mason/packages/jdtls/lombok.jar", -- Lombok 추가
          "-jar", launcher_jar,
          "-configuration", config_path,
          "-data", workspace_dir,
        },
        root_dir = lspconfig.util.root_pattern("pom.xml", "gradlew", "build.gradle", ".git"),
      })

      -- TypeScript 설정
      lspconfig.ts_ls.setup({
        on_attach = function(client, bufnr)
          -- TypeScript LSP의 기본 포맷터 비활성화 (null-ls 등 외부 포맷터를 사용하는 경우)
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
      lspconfig.ltex.setup({
        -- ltex‑ls를 적용할 파일 타입 목록을 가능한 한 넓게 지정합니다.
        -- 여기서는 예시로 흔히 사용하는 여러 텍스트 및 코드 관련 파일 타입을 나열했습니다.
        filetypes = {
          "plaintext", "markdown", "tex", "gitcommit", "org",
          "java", "javascript", "javascriptreact", "typescript", "typescriptreact",
          "html", "css", "lua", "vim", "sh", "json", "yaml"
        },
        -- on_attach에서 제외 파일 타입이면 클라이언트를 중지합니다.
        on_attach = function(client, bufnr)
          local ft = vim.bo.filetype
          for _, excluded in ipairs(excluded_filetypes) do
            if ft == excluded then
              -- 해당 버퍼에서는 ltex‑ls를 중지시켜, 검사하지 않도록 함
              client.stop()
              return
            end
          end
        end,
        settings = {
          ltex = {
            language = "en-US",
            dictionary = {
              ["en-US"] = {},
            },
            -- 필요에 따라 추가 설정 (예: disabledRules, additionalRules 등) 적용 가능
          },
        },
      })
    end,
  },
}

