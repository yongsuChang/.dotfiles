# WSL 환경 설정
## 0. WSL이란?
- Windows Subsystem for Linux
- Windows에 기본으로 설치할 수 있는 linux 환경
- [WSL 설명][wsl-link]

### 0-1. 사용 이유?
- 개발 세팅 간편화
- 개발 환경과 배포 환경의 유사성 확보
- 개발 환경 복제

## 1. WSL 설치
1. Microsoft Store에서 Ubuntu 24.x 다운로드
2. `Windows 기능 켜기/끄기`에서 `Linux용 Windows 하위 시스템` 활성화하기
3. cmd 창에서 ``` wsl.exe --update ``` 실행
4. 다운 받은 Ubuntu 24.x 실행

## 2. 필요 프로그램 설치
### 2-1. 기본 준비
    ```
    // 기본 프로그램들 설치 준비
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install

    // zsh(Custom shell) 설치
    sudo apt install zsh

    // zsh 다시 켜기
    exec zsh
    ```
- [zsh 설정 덮어쓰기 방법으로 가기](https://github.com/yongsuChang/.dotfiles/tree/main?tab=readme-ov-file#%EA%B7%B8%EB%8C%80%EB%A1%9C-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0 "Go to zsh")

    - github ssh 등록
        - 키 생성
        ```
        // ssh key 생성
        cd ~
        ssh-keygen -t ed25519 -C "your-email@example.com"

        // ssh key 확인
        cat ~/.ssh/id_ed25519.pub
        // ssh-ed25519 ~~~~~~ e메일 주소 까지 다 복사해야 함
        ```

        - Github에 ssh key 등록
            - GitHub에 로그인 후, Settings → SSH and GPG keys 이동
            - "New SSH Key" 버튼 클릭
            - Title에는 WSL을 구분할 수 있는 이름 입력 (예: Gram SSH Key)
                - Authentication keys 등록
                - Signing keys 등록
        ```
        // 연결 확인
        ssh -T git@github.com
        ```

        - git 관련 여러 설정 등록
        ```
        git config --global user.name "Your Name"
        git config --global user.email "your-email@example.com"
        git config --global core.sshCommand "ssh -i ~/.ssh/id_ed25519"
        git config --global core.editor vim
        // editor는 나중에 nvim으로 바꾸는게 좋음
        ```

### 2-2. 편의 기능 설치

> 개인적으로는 3-1에 있는 font 및 p10k 추천, neovim 다운 뒤 NvChad 등 설치도 추천

- neovim : Improved vim
    - 0.11.0-dev
    ```
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt update
    sudo apt install neovim -y
    ```

```
// install
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt install neovim

// settings for making `vi`, `vim` command to process neovim
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 10
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 10
sudo update-alternatives --config vi
```

- ripgrep : Improved grep
    ```
    sudo apt install ripgrep
    ```

- lsd : Prettier ls
    ```
    sudo apt install lsd

    // set command `ls`
    sudo update-alternatives --install /usr/bin/ls ls /usr/bin/lsd 10
    ```

- fd-find : file name search
    ```
    sudo apt install fd-find
    ```
- set command `fd` for fd-find
    ```
    // set command `fd` for fd-find
    mkdir -p ~/.local/bin
    ln -s $(which fdfind) ~/.local/bin/fd
    ```

### 2-3. 작업 필수 프로그램
***FrontEnd***
- NodeJS : 
    - Link: [NodeJs][node-link]
    - node : 22.13.0
    - npm : 10.9.2
    ```
    curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh
    sudo -E bash nodesource_setup.sh
    sudo apt-get install -y nodejs
    ```

- gcc : compiler
    ```
    sudo apt install gcc
    ```

- pnpm : faster package installer
    - Link: [pnpm install][pnpm-link]
    - 10.0.0
    ```
    npm install -g pnpm@latest-10
    ```

***BackEnd***
- openjdk17 (21은 숫자만 바꾸면 가능)
    ```
    sudo apt update
    sudo apt install openjdk-17-jdk
    ```
- maven
    ```
    sudo apt update
    sudo apt install maven
    ```
- gradle
    ```
    sudo apt update && sudo apt install -y gradle
    ```

## 3. Optional
### 3-1. 커스터마이징 기능
- fonts : 개발에 좋게 unicode glyph 변경해 놓은 폰트
    - 디원더 default: CaskaydiaCove Nerd font
    - Link: [NERD FONTS][nerdfonts-link]
- p10k : Shell styling
    - Link : [PowerLevel10k][powerlevel10k-link]
- NvChad : Fancier neovim
    - Link: [NvChad install][nvchad-link]

### 3-2. 추가 기능
- net-tools : netstat등 사용 가능, 네트워크 상황 감시 가능
    ```
    sudo apt update
    sudo apt install net-tools
    ```
- gh : github cli - GitHub Actions 등을 shell 환경에서 사용할 수 있게 해 줌
     ```
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install gh
    ```
- maria-db : mysql fork
    ```
    sudo apt update
    sudo apt install mariadb-server mariadb-client -y
    ```
- pass & gpg : password manager - 비밀키등 저장 해 놓을 수 있는 내부 보안 DB
    ```
    // install
    sudo apt update
    sudo apt install pass gpg

    // assert
    pass --version

    // create password
    gpg --gen-key
    gpg --list-keys

    // init
    pass init <gpg-id>

    // add password
    pass insert <password-name>

    // show password
    pass database/<password-name>
    // ex) pass database/github_token
    ```
    ```
    // git integration

    // make git repository
    cd ~/.password-store
    git init
    git remote add origin <git-repo>

    // commit
    git add .
    git commit -m "init"
    git push origin main
    ```
    ```
    // clone from other device

    // export gpg key
    git clone <git-repo> ~/.password-store
    gpg --export-secret-keys --armor "your-email@example.com" > gpg-key.asc

    // import gpg key
    gpg --import gpg-key.asc

    // set trust
    gpg --edit-key "your-email@example.com" trust

    // init
    pass init <gpg-id> // SEC키 사용
    ```
- telnet : network tool - ssh 연결 테스트 등 가능
    ```
    sudo apt update
    sudo apt install telnet
    ```

## 4.환경 설정
### 4-1. (선택)환경 설정 덮어쓰기
- repository clone or fork
    - 원한다면 fork해서 별도 repository로 나가도 됨(개인 관리 쉬움)
    ```
    // HTTPS
    git clone https://github.com/yongsuChang/.dotfiles.git

    // SSH
    git clone git@github.com:yongsuChang/.dotfiles.git
    ```
    - 이후 [Nvim 설정 그대로 적용하기][Adjust-link] 참조

### 4-2. (선택)환경 설정 직접 하기
- zsh
    ```
    // 홈 디렉토리에 .zshrc 만들어서 적용
    vim ~/.zshrc
    ```
- neovim
    ```
    // .config/nvim에서 설정
    cd ~/.config/nvim

    // 가장 기본 세팅
    vim init.lua

    // ==== 추가적으로 NvChad등 설치 하면 하위 lua파일에서 더 관리 ====
    cd ~/.config/nvim/lua

    // 기본 세팅
    vim chadrc.lua

    // 키 매핑 세팅
    vim mappings.lua
    ```

## 5. (선택)IDE 사용
### 5-1. IntelliJ
- IntelliJ linlux용 다운로드(tar.gz 형식)
    - [IntelliJ linux 다운][Intellij-link]

    ```
    // 접근 쉬운 temp 폴더 생성
    mkdir ~/temp
    chmod 777 ~/temp

    // windows 탐색창에 \\wsl$를 입력하면 wsl에 접근 가능
    // temp로 파일 이동, 압축 풀기
    cd ~/temp
    tar -xzf ideaIC-*.tar.gz
    // 안 되면   tar -xzf ideaIU-*.tar.gz

    // 폴더 이동
    sudo mv idea-IC-*/ /opt/idea

    // 실행
    /opt/idea/bin/idea
    // 또는 /opt/idea/bin/idea.sh
    ```

### 5-2. VCS
    - Plugin으로 WSL 다운
    - 최좌측 최하단 파란 버튼 클릭(호버시 Open a remote window라고 뜸)
        - Connect to Wsl로 진입


## 6. 환경 변수
- AWS parameterStore 사용 시 환경 변수 설정
    ```
    AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY
    AWS_REGION
    ```
- DB cloning 할 때 다음 변수 설정
    ```
    DB_PRODUCT_PASSWORD
    DB_PRODUCT_URL
    DB_TEST_URL

    ```


[wsl-link]: https://learn.microsoft.com/ko-kr/windows/wsl/install, "Go "
[node-link]: https://github.com/nodesource/distributions?tab=readme-ov-file#using-ubuntu-nodejs-22 "Go node"
[pnpm-link]: https://pnpm.io/ko/installation "Go pnpm"
[nerdfonts-link]: https://www.nerdfonts.com "Go Nerdfonts"
[powerlevel10k-link]: https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#installation "Go p10k"
[nvchad-link]: https://nvchad.com/docs/quickstart/install "Go NvChad"
[Adjust-link]: https://github.com/yongsuChang/.dotfiles/tree/main/nvim#%EA%B7%B8%EB%8C%80%EB%A1%9C-%EC%A0%81%EC%9A%A9%ED%95%98%EA%B8%B0, "Go Adjust"
[Intellij-link]: https://www.jetbrains.com/idea/download/download-thanks.html?platform=linux&code=IIC "Go IntelliJ download"
