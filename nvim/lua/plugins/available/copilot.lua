return {
  -- Copilot Lua plugin
  {
    "zbirenbaum/copilot.lua",
    lazy = false, --바로 시작
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true, -- suggestion 기능 활성화
--          keymap = {
--            accept = "<C-j>", -- 제안을 수락하는 키 매핑
--            next = "<C-]>",
--            prev = "<C-[>",
--            dismiss = "<C-c>",
--          },
        },
        panel = { enabled = false }, -- 패널 기능은 끔
      })
    end
  },

  -- Copilot 공식 플러그인
  {
    "github/copilot.vim",
    lazy = false, -- 항상 로드되도록 설정
    config = function()
      -- 추가 설정이 필요하면 여기서 처리
      -- vim.g.copilot_no_tab_map = true
      -- vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  },
--  -- copilot-cmp: Copilot을 nvim-cmp 소스처럼 쓰기
--  {
--    "zbirenbaum/copilot-cmp",
--    -- Lazy.nvim에서는 after 대신 dependencies나 다른 키워드를 사용할 수 있음
--    lazy = false, --바로 시작
--    dependencies = { "zbirenbaum/copilot.lua" },
--    config = function()
--      require("copilot_cmp").setup()  -- 기본 설정 적용
--
--      -- nvim-cmp 설정에 copilot 소스를 등록
--      local cmp = require("cmp")
--      cmp.setup({
--        sources = {
--          { name = "copilot", group_index = 2 },
--          { name = "nvim_lsp" },
--          { name = "buffer" },
--          -- ...
--        },
--        -- 키매핑, snippet 설정 등 다른 cmp 설정...
--      })
--    end
--  },
}

