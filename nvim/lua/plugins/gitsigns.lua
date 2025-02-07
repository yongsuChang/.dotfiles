return {
  -- 각 줄을 누가 변경했는지 blame하기 위해 사용
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      -- 필요에 따라 다른 옵션 추가 가능
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },
}
