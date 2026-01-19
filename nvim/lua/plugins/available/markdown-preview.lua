return {
  -- Markdown 미리보기 플러그인 추가
  {
    "iamcco/markdown-preview.nvim",
    lazy = false, -- 항상 로드
    build = "cd app && npm install", -- 설치 후 npm 의존성 설치
    ft = { "markdown" }, -- Markdown 파일에서만 활성화
    config = function()
      vim.g.mkdp_auto_start = 1 -- Markdown 파일 열 때 자동으로 미리보기 시작
      vim.g.mkdp_browser = "" -- 시스템 기본 브라우저 사용
      vim.g.mkdp_auto_close = 1       -- Neovim에서 Markdown 파일을 닫으면 미리보기 종료
      vim.g.mkdp_refresh_slow = 0     -- 내용 변경 시 즉시 새로고침
      vim.g.mkdp_port = 8000          -- 미리보기를 제공할 포트 (설정값: 8000)
    end,
  },
}
