1. Copilot

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
