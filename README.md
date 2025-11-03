# 디원더 linux-WSL 설정 파일들에 대한 설명입니다.
## WSL 전체 환경 설정 방법
- [WSL 환경설정 방법으로 가기](https://github.com/yongsuChang/.dotfiles/blob/main/manuals/wsl_manual.md "Go to manual")
## 설정 덮어쓰기 방법
- [zsh 설정 덮어쓰기 방법으로 가기](https://github.com/yongsuChang/.dotfiles/tree/main?tab=readme-ov-file#%EA%B7%B8%EB%8C%80%EB%A1%9C-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0 "Go to zsh")
- [NeoVim 설정 덮어쓰기 방법으로 가기](https://github.com/yongsuChang/.dotfiles/tree/main/nvim "Go to nvim")
- <a href="https://github.com/yongsuChang/.dotfiles/blob/main/manuals/addon_install.md" target="_blank">추가 기능 설치 방법으로 가기</a>
## zsh 관련 설정
- `.zshrc` : zsh 설정 파일
### 그대로 사용하기
    - 이 repository clone
    - 기존 zsh 관련 설정 파일들을 삭제하고, 이 zshrc를 심볼릭 링크 해야 함
    ```
    // 기존 설정 파일 삭제
    rm -rf ~/.zshrc

    // 심볼릭 링크 생성
    ln -s ~/{이 repository 상대 위치}/.zshrc ~/.zshrc
    ```
### 기본 설정
- `powerlevel10k` : 터미널 프롬프트 설정
- `fcitx` : 한글 입력 설정
- `pnpm` : pnpm 환경 설정
- `nvm` : Node Version Manager 환경 설정
- `gradle` : Gradle 환경 설정
- `IntelliJ` : IntelliJ GUI 사용 금지 설정
### 키매핑
- `ls` : `lsd`로 대체
- `ll` : `lsd -l`로 대체
- `l` : `lsd -Al`로 대체
- `notpush` : git log로 브랜치 비교
- `clipboard` : 클립보드 오류시 해결
- `sii` : IntelliJ 실행 (백그라운드 실행)
- `deploy` : 배포 관련 명령어
    - `deploy <project> <branch> <server>` : 배포 명령어
        - `project` : 프로젝트 이름 (`admin`, `report`)
        - `branch` : 브랜치 이름
        - `server` : 서버 이름 (`prod`, `prod2`, `internal`, `staging`, `test`)
- `dbclone` : DB 클론 명령어
    - DB 관련 Pass 세팅이 되어있어야 함
    local password=$(pass show DB_PRODUCT_PASSWORD)
    local addressProduct=$(pass show DB_PRODUCT_URL)
    local addressTest=$(pass show DB_TEST_URL)
        - DB_PRODUCT_PASSWORD : DB 비밀번호
        - DB_PRODUCT_URL : 본 DB 주소
        - DB_TEST_URL : 복사할 테스트 DB 주소
    - `dbclone <schema_name>` : DB 클론 명령어
        - `schema_name` : 만들고자 하는 스키마 이름
- [vim 관련 명령어](https://github.com/yongsuChang/.dotfiles/tree/main/nvim#%ED%82%A4%EB%A7%B5%ED%95%91 "Go to vim key mapping")

