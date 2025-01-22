# WSL 환경 설정
## 0. WSL이란?
- Windows에 기본으로 설치할 수 있는 linux 환경
- [WSL 설명][wsl-link]

### 0-1. 사용 이유?
- 개발 세팅 간편화
- 개발 환경과 배포 환경의 유사성 확보

## 1. WSL 설치
1. Microsoft Store에서 Ubuntu 24.x 다운로드
2. 다운 받은 Ubuntu 24.x 실행

## 2. 필요 프로그램 설치
### 2-1. 기본 준비
```
// 기본 프로그램들 설치 준비
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install

// zsh(Custom shell) 설치
sudo apt install zsh

```

### 2-2. 편의 기능 설치
- neovim : Improved vim
    - 0.9.5
    - Link: [neovim install][nvim-link]
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
- NodeJS : 
    - Link: [NodeJs][node-link]
    - node : 22.13.0
    - npm : 10.9.2

- gcc : compiler
    ```
    sudo apt install gcc
    ```

- pnpm : faster package installer
    - Link: [pnpm install][pnpm-link]
    - 10.0.0

### 2-4. 커스터마이징 기능
- fonts : 개발에 좋게 unicode glyph 변경해 놓은 폰트
    - 디원더 default: CaskaydiaCove Nerd font
    - Link: [NERD FONTS][nerdfonts-link]
- p10k : Shell styling
    - Link : [PowerLevel10k][powerlevel10k-link]
- NvChad : Fancier neovim
    - Link: [NvChad install][nvchad-link]


### 환경 변수
- AWS parameterStore 사용 시 환경 변수 설정
    ```
    export AWS_ACCESS_KEY_ID=your-access-key-id
    export AWS_SECRET_ACCESS_KEY=your-secret-access-key
    export AWS_REGION=your-region
    ```

[wsl-link]: https://learn.microsoft.com/ko-kr/windows/wsl/install, "Go "
[nvim-link]: https://github.com/neovim/neovim/blob/master/INSTALL.md#ubuntu "Go neovim"
[node-link]: https://github.com/nodesource/distributions?tab=readme-ov-file#using-ubuntu-nodejs-22 "Go node"
[pnpm-link]: https://pnpm.io/ko/installation "Go pnpm"
[nerdfonts-link]: https://www.nerdfonts.com "Go Nerdfonts"
[powerlevel10k-link]: https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#installation "Go p10k"
[nvchad-link]: https://nvchad.com/docs/quickstart/install "Go NvChad"


