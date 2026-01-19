return {
  -- 이모지 자동완성 플러그인 추가
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        sources = {
          { name = "emoji" }, -- 이모지 자동완성 소스
        },
      })
    end,
  },
}
