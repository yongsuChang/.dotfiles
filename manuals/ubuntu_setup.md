# Ubuntu setup guide
## 기본 설정
### 필수 패키지 설치
```bash
sudo apt update
sudo apt install -y curl git vim net-tools
sudo apt upgrade -y
```
### 시간대 설정
- 현재 시간대 확인
```bash
timedatectl
```
- 시간대 설정(예: Asia/Seoul)
```bash
sudo timedatectl set-timezone Asia/Seoul
```
### github SSH 키 생성 및 등록
- SSH 키 생성
```bash
ssh-keygen -t ed25519
```
- SSH 키 복사
```bash
cat ~/.ssh/id_ed25519.pub
```
- github에 SSH 키 등록
  - github 설정 페이지 접속
  - "SSH and GPG keys" 메뉴 선택
  - "New SSH key" 버튼 클릭
  - Title 입력 및 Key에 복사한 SSH 키 붙여넣기 후 "Add SSH key" 버튼 클릭(Authencation key, signing key 모두 가능)
### 편의 패키지 설치
```bash
# ripgrep, fd-find, lsd 설치
sudo apt install -y ripgrep fd-find lsd
```
### zsh 설치
- 폰트 설치(Nerd Fonts - CaskaydiaCove NF)
```bash
# 폰트 설치
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CascadiaCode.zip

# 필요 패키지 설치
sudo apt install -y zip unzip fontconfig
unzip CascadiaCode.zip -d ~/.local/share/fonts/

# 폰트 캐시 갱신
fc-cache -fv
```
- 추가 패키지 설치(혹시 모를 플러그인 빌드 오류 방지)
```bash
sudo apt install -y npm gcc
# node update
sudo npm install -g n
# LTS 버전 설치
sudo n install 24
# 쉘 재실행(리로드 해야 node 버전이 반영됨)
exec zsh
```
- Powerlevel10k 설치
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
```
- zsh 설치 및 기본 쉘 변경
```bash
sudo apt install -y zsh
chsh -s $(which zsh)
exec zsh
```
### nvim 설치
- Neovim PPA 추가 및 설치
    - Ubuntu 패키지 레포지토리의 neovim 버전이 낮기 때문에, release 페이지에서 직접 받아 설치
    - [Release Page](https://github.com/neovim/neovim/releases)
    - nvim-linux-x86_64.tar.gz로 다운 받기
```bash
# Neovim 다운로드
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz
# 압축 해제
tar xzvf nvim-linux-x86_64.tar.gz
# /usr/local/neovim 디렉토리에 이동 및 심볼릭 링크 생성
sudo mv nvim-linux-x86_64 /usr/local/neovim
sudo ln -s /usr/local/neovim/bin/nvim /usr/bin/nvim
```
- NVChad 설치
```bash
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
```
- Lazy 관리
```vim
:Lazy sync
```
- Copilot authentication
```vim
# vim command mode에서 아래 명령어 실행
:Copilot auth
# https://github.com/login/device에 접속하여 코드 입력 후 인증 완료
```
## 개인 설정 복사
### UserHome directory(~/)
- .gitconfig
- .vimrc
- .zshrc
- .zsh_functions
- .tmux.conf
### config directory(~/.config/)
- nvim/

