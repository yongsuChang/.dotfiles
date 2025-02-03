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

3. Tmux
- 설치
    - tmux
        ```
        sudo apt update
        sudo apt install -y tmux
        ```
    - tpm : tmux plugin manager
        ```
        // install
        git clone git@github.com:tmux-plugins/tpm.git ~/.tmux/plugins/tpm
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        ```

- 설정
    - tmux 설정 파일 생성
        ```
        touch ~/.tmux.conf
        ```
    - tmux 설정 파일에서 tpm을 통해 plugin 설치시 (tmux <leader>는 기본 ctrl + b, 나는 ctrl + s로 변경)
        ```
        <leader> + I // 설치
        <leader> + R // 업데이트
        ```
    - vim-tmux-navigator
        - 설치
            - ~/.tmux.conf
                ```
                set -g @plugin 'christoomey/vim-tmux-navigator'
                ```
            - tmux 설정 파일에서 tpm을 통해 plugin 설치
                ```
                <leader> + I
                ```
        - 설정
            - ~/.conf/nvim/init.lua
                - netrw 기존 키 매핑을 비활성화
                    ```
                    let g:tmux_navigator_disable_netrw_workaround = 1
                    ```
            - neovim에서 기존 키 매핑 삭제
                ```
                :unmap <C-h>
                :unmap <C-j>
                :unmap <C-k>
                :unmap <C-l>
                ```
            - tmux 설정
                - ~/.tmux.conf
                    ```
                    # 창 이동 단축키 (<leader> + h, j, k, l)
                    bind-key h select-pane -L
                    bind-key j select-pane -D
                    bind-key k select-pane -U
                    bind-key l select-pane -R

                    # vim-tmux-navigator를 통해 ctrl + hjkl 또는 화살표로 tmux -> nvim 이동 가능하게 해 줌
                    set -g @vim_navigator_mapping_left "C-Left C-h"  # use C-h and C-Left
                    set -g @vim_navigator_mapping_right "C-Right C-l"
                    set -g @vim_navigator_mapping_up "C-Up C-k"
                    set -g @vim_navigator_mapping_down "C-Down C-j"
                    set -g @vim_navigator_mapping_prev ""  # removes the C-\ binding

                    ```
                - ~/.conf/nvim/lua/plugins/tmux.lua
                    ```
                    return {
                      {
                        "christoomey/vim-tmux-navigator",
                        lazy = false,
                        cmd = {
                          "TmuxNavigateLeft",
                          "TmuxNavigateDown",
                          "TmuxNavigateUp",
                          "TmuxNavigateRight",
                          "TmuxNavigatePrevious",
                          "TmuxNavigatorProcessList",
                        },
                        keys = {
                          { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
                          { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
                          { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
                          { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
                          { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
                              -- 화살표 키 추가 매핑
                          { "<c-Left>",  "<cmd>TmuxNavigateLeft<cr>" },
                          { "<c-Down>",  "<cmd>TmuxNavigateDown<cr>" },
                          { "<c-Up>",    "<cmd>TmuxNavigateUp<cr>" },
                          { "<c-Right>", "<cmd>TmuxNavigateRight<cr>" },
                        },
                      }
                    }
                    ```

        
