return {
  -- 이모지 및 아이콘 표시 플러그인 추가
  {
    "kyazdani42/nvim-web-devicons", -- 이모지 및 아이콘 표시
    lazy = false, -- 항상 로드
    config = function()
      require("nvim-web-devicons").setup {
        default = true, -- 기본 이모지 설정 활성화
      }
    end,
  },
}
