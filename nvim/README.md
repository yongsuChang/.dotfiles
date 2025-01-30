# NeoVim 및 NvChad 설정 관련 내용을 정리한 문서입니다.

## 그대로 적용하기
- 이 repository clone
- 기존 nvim 관련 설정 파일들을 삭제하고, 이 nvim 폴더를 심볼릭 링크 해야 함
    ```
    // 기존 nvim 폴더가 있을 경우 삭제(기존 설정이 날아가니 주의)
    rm -rf ~/.config/nvim

    // 심볼릭 링크 생성
    ln -s ~/{이 repository 상대 위치}/nvim ~/.config/nvim
    ```

## 구성
- `init.vim`: vim 설정 파일
- `lua/`: lua 설정 파일들
    - `chadrc.lua`: NvChad 설정 파일
    - `mappings.lua`: 키맵핑 설정 파일
    - `plugin/`: 플러그인 관련 설정 파일들
        - `copilot.lua`: GitHub Copilot 설정 파일
        - `lspconfig.lua`: LSP 설정 파일
        - `plugins.lua`: 플러그인 설정 파일

## 플러그인
- NvChad 기본 플러그인들
- `github/copilot.vim`: GitHub Copilot 플러그인
- `nvim-telescope/telescope.nvim`: 플러그인 검색 및 선택 플러그인
- `nvim-pack/nvim-spectre`: 검색 및 치환 플러그인
- `norcalli/nvim-colorizer.lua`: 색상 코드 표시 플러그인
- `tailwindcss-colorizer-cmp`: Tailwind CSS 색상 코드 표시 플러그인
- `catgoose/nvim-colorizer.lua`: 색상 코드 표시 플러그인
- `markdown-preview.nvim`: 마크다운 미리보기 플러그인
- `kyazdani42/nvim-web-devicons`: 아이콘 표시 플러그인
- `hrsh7th/nvim-cmp`: 이모지 자동완성 플러그인

## 키맵핑
- `ctrl + p`: 파일 검색
- `ctrl + t`: 테마 변경
- `shift + F`: 텍스트 검색
- `shift + R`: 검색 및 치환
- `F2`: NvimTree 열기/닫기
- `F3`: NvimTree 새 창 열기(포커스)
- `F4`: 전체 경로 검색
- `F5`: 파일명만 검색
- `F7`: 이전 버퍼로 이동
- `F8`: 다음 버퍼로 이동
- `F9`: 버퍼 닫기
- `alt + 1~9`: 1번 ~ 9번 버퍼로 이동

