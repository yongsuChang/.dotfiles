1. Copilot
    - nvim에 plugin으로 copilot 설치
        ```
        // ex) ~/.config/nvim/plugins/plugins.lua
          {
            "github/copilot.vim",
            -- event를 통해 불필요한 시점 로딩 방지 (선택)
            -- event = "InsertEnter",
            lazy = false,
            config = function()
              -- 필요한 설정이 있으면 추가 가능
              -- 기본적으로 :Copilot setup으로 로그인 진행
            end,
          },
        ```
    - Lazy에서 설치 후 Copilot 인증
        ```
        :Lazy sync
        :Copilot auth
        ```
    - 만약 잘 등록이 안 된다면 WSL을 아예 종료한 뒤 켜거나 다음을 등록한 뒤 다시 시도
        ```
        // ~/.ssh/config
        Host github.com
          HostName ssh.github.com
          Port 443
          User git
          IdentityFile ~/.ssh/id_ed25519
          ProxyCommand none
          AddKeysToAgent yes
        ```
2. Jira-Cli
    - <a href="https://github.com/ankitpokhrel/jira-cli?tab=readme-ov-file" target="_blank"> Jira-cli 사이트 </a>
    - Go 설치
        ```
        // 1) 저장소 업데이트
        sudo apt-get update

        // 2) Go 설치
        sudo apt-get install -y golang-go

        // 3) 버전 확인
        go version
        //예) go version go1.20.6 linux/amd64
        ```
    - Jira-Cli 설치
        ```
        go install github.com/ankitpokhrel/jira-cli/cmd/jira@latest
        ```
    - Jira API Token 발급
        - <a href="https://id.atlassian.com/manage-profile/security/api-tokens" target="_blank">[토큰 발행]</a> 에서 발급
    - Jira-Cli init
        ```
        // Jira API Token 등록
        export JIRA_API_TOKEN=<your-api-token>
        jira init

        // Installation type
        Cloud

        // Link to Jira server
        https://<your-domain>.atlassian.net

        // Login email
        <your-nickname>@theoneder.co.kr

        // Default project
        PROD

        // Default board
        Progress // 다른 것일 수도, 한글은 안됨
        ```
