local plugins = {
  -- Copilot 공식 플러그인
  {
    "github/copilot.vim",
    -- event를 통해 불필요한 시점 로딩 방지 (선택)
    -- event = "InsertEnter",
    config = function()
      -- 필요한 설정이 있으면 추가 가능
      -- 기본적으로 :Copilot setup으로 로그인 진행
    end,
  },
}

return plugins

