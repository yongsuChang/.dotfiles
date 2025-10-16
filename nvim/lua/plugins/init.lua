return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- Java: nvim-jdtls (이 플러그인은 자체 런처를 쓰므로 여기서는 lspconfig 호출 불필요)
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    -- 필요시 별도 설정 파일에서 jdtls.start_or_attach 호출
    -- config = function() require("configs.jdtls") end,
  },

  -- LSP (TypeScript/JavaScript, TailwindCSS) - 새 API로 통합
  {
    "neovim/nvim-lspconfig",
    ft = { "typescript", "javascript", "html", "css" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- 기존: require("lspconfig").tsserver.setup({})
      -- 새 API: 서버 설정을 정의하고 활성화
      vim.lsp.config("tsserver", {
        -- 필요 옵션을 여기에
        -- settings = { ... },
      })
      vim.lsp.enable("tsserver")

      -- 기존: require("lspconfig").tailwindcss.setup({})
      vim.lsp.config("tailwindcss", {
        -- 필요 옵션을 여기에
      })
      vim.lsp.enable("tailwindcss")
    end,
  },

  -- 예시 트리시터 (원문 주석 유지)
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = {
  --     ensure_installed = { "vim", "lua", "vimdoc", "html", "css" },
  --   },
  -- },
}

