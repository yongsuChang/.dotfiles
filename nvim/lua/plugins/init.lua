return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- Java 관련 LSP 설정
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    dependencies = {
      "neovim/nvim-lspconfig"
    },
    -- 만약 별도의 설정을 하고 싶다면 config 블록 추가
    config = function()
      -- 여기서 jdtls 설정 가능
      require "configs.lspconfig"
    end,
  },

  -- TypeScript 관련 LSP 설정
  {
    "neovim/nvim-lspconfig",
    ft = { "typescript", "javascript" },
    dependencies = {
      "williamboman/mason.nvim", -- LSP 설치 관리
      "williamboman/mason-lspconfig.nvim" -- LSP 설정 관리
    },
    config = function()
      require("lspconfig").tsserver.setup({})
    end,
  },

  -- TailwindCSS 관련 LSP 설정
  {
    "neovim/nvim-lspconfig",
    ft = { "html", "css", "javascript", "typescript" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim"
    },
    config = function()
      require("lspconfig").tailwindcss.setup({})
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
