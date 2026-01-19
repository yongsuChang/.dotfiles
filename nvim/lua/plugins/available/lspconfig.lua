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
          "jdtls",
          "ts_ls",
          "tailwindcss",
        },
      })

      ----------------------------------------------------------------
      -- OS / jdtls 경로 설정
      ----------------------------------------------------------------
      -- jdtls 설정은 configs/jdtls.lua에서 nvim-jdtls 플러그인을 통해 처리됩니다.

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

