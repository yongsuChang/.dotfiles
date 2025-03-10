# AI Tool Settings
# 목적

- 각 개발자의 효율성을 극대화 시키기
    - 사람의 Resource는 한정되어있음,
        - 효율적으로 사람이 할 수 있는 일만 하더라도 바쁨
            - **판단을 내리는 것에 업무가 집중 되어야 함**
        - 기계가 할 수 있는 것들은 기계에게 맡겨야 함
            - 반복적인 일들은 기계에게 맡길 수 있음
                - 제대로 된 환경 설정하여 check, test, 배포 등 자동화 가능
            - **생산성 있는 일들도 기계에게 맡기기 가능해 짐**
                - AI model들의 성능이 많이 올라와서 이제 맡기기 가능


# 현재 사용해 볼 만한 AI Tools

## WindSurf Editor
[Codeium - WindSurf](https://codeium.com/)
- Codeium사에서 만든 AI IDE
    - VSC fork project
    - Chat / Write mode
    - install on Widows
        - [다운로드](https://codeium.com/windsurf)
        ```
        # install on MacOS
        brew install --cask windsurf
        ```
## Cursor
[Anysphere - Cursor](https://www.cursor.com/)
- Anysphere사에서 만든 AI Code Editor
    - VSC fork project
    - Ask / Edit / Agent mode
    - install on Widows
        - [다운로드](https://www.cursor.com/downloads)
        ```
        # install on MacOS
        brew install --cask cursor
        ```
## Visual StudioCode Insiders
[VSC Insiders](http://code.visualstudio.com/insiders)
- Microsoft사에서 만든, 실험 기능들 추가 된 VSC
    - 아직 AI agent mode는 정식 기능이 아님
        - 그래서 Insiders에서 공짜로 사용 가능
    - Chat / Copilot Edits - Edit, Agent mode
    - install on Windows
        - [다운로드](http://code.visualstudio.com/insiders)
        ```
        # install on MacOS
        brew install --cask visual-studio-code@insiders
        ```
## Claude Code
[Anthropic - Claude Code](https://console.anthropic.com/)
- Anthropic사에서 만든 Agent coding tool
    - 현재는 terminal내에서 CLI 프로그램으로 동작
        - 프로젝트 내부 전체 스캐닝 하면서 작업도 가능
    - 비쌈... but 가장 기능 좋음
        - 연산하는 만큼 요금 나감

        ```
        # .zshrc 에 아래 추가
        alias claude='pnpm dlx @anthropic-ai/claude-code'

        # zsh 재시작
        exec zsh

        # 켜기
        claude
        ```

