#!/bin/bash
# 스크립트 예: start_work.sh
# 실행 권한 부여: chmod +x start_work.sh

# 1. 먼저 pass 인증을 진행합니다.
echo "pass 인증을 진행합니다. 패스프레이즈를 입력해 주십시오."
pass show JIRA_API_TOKEN > /dev/null

SESSION="morning"
WINDOW="work"

# 2. tmux 세션 생성
# 좌측 pane (인덱스 0): ~/git에서 zsh 로그인 셸을 실행한 뒤, nvim을 실행하고 종료 후 다시 zsh 유지
tmux new-session -d -s "$SESSION" -n "$WINDOW" -c ~/git "zsh -il -c 'nvim; exec zsh'"

# 3. 좌우 분할: 우측 pane (인덱스 1)
# ~/git/life에서 zsh 로그인 셸을 실행한 뒤, nvim을 실행하고 종료 후 다시 zsh 유지
tmux split-window -h -c ~/git/life "zsh -il -c 'nvim; exec zsh'"

# 4. 우측 pane이 완전히 시작될 때까지 대기
sleep 1

# 5. 우측 pane (인덱스 1)에 F3 키 전송 (예: nvim 내에서 F3에 매핑된 기능 실행)
tmux send-keys -t "${SESSION}:0.1" F3

# 6. 우측 pane (인덱스 1)을 선택한 후 상하 분할하여 하단 pane (인덱스 2) 생성
tmux select-pane -t "${SESSION}:0.1"
sleep 0.5  # pane 선택 후 안정화를 위해 잠시 대기

# 하단 pane은 ~/git/life 디렉토리에서 zsh 로그인 셸을 실행
tmux split-window -v -t "${SESSION}:0.1" -c ~/git/life "zsh -il"
sleep 1
# 인터랙티브 셸이 완전히 시작된 후, jl 명령어를 전송
tmux send-keys -t "${SESSION}:0.2" "jl" Enter

# 7. 기본 선택 pane을 좌측 pane (인덱스 0)으로 변경
tmux select-pane -t "${SESSION}:0.0"

# 8. tmux 세션에 attach
tmux attach-session -t "$SESSION"

