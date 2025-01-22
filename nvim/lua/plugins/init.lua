return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

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

  {
    "github/copilot.vim",
    lazy = false, -- 항상 로드되도록 설정
    config = function()
      -- 추가 설정이 필요하면 여기서 처리
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
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
