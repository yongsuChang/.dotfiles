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
  -- LazyGit 설정
  {
    "kdheepak/lazygit.nvim", -- lazygit 플러그인
    cmd = "LazyGit",         -- :LazyGit 커맨드 호출 시에만 로드합니다.
    config = function()
      -- lazygit 설정 (옵션이 있다면 추가)
      -- require("lazygit").setup({
        -- 예: border = "rounded",
        -- 필요한 옵션들을 여기에 추가할 수 있습니다.
      -- })
    end,
  },
}
