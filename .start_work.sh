#!/bin/bash
# 스크립트 예: start_work.sh
# 실행 권한 부여: chmod +x start_work.sh

# 1. 먼저 pass 인증을 수행합니다.
echo "pass 인증을 진행합니다. 패스프레이즈를 입력해 주십시오."
pass show JIRA_API_TOKEN > /dev/null

# 2. 이후 tmux 세션을 생성합니다.
SESSION="morning"
WINDOW="work"

# 좌측 pane (인덱스 0): ~/git에서 nvim 실행 후 bash 유지
tmux new-session -d -s "$SESSION" -n "$WINDOW" -c ~/git "nvim; exec bash"

# 우측 pane (인덱스 1): ~/git/life에서 nvim 실행 후 bash 유지
tmux split-window -h -c ~/git/life "nvim; exec bash"

# 우측 pane이 시작될 때까지 대기
sleep 0.3

# 우측 pane (인덱스 1)에 F3 키 전송
tmux send-keys -t "${SESSION}:0.1" F3

# 우측 pane (인덱스 1)을 선택한 후 상하 분할하여 하단 pane (인덱스 2) 생성
tmux select-pane -t "${SESSION}:0.1"
sleep 0.3  # pane 선택 후 안정화를 위해 잠시 대기

# 하단 pane을 인터랙티브 zsh로 실행한 후, 일정 대기 후에 jl 명령어 전송
tmux split-window -v -t "${SESSION}:0.1" -c ~/git/life "zsh -il"
sleep 0.3
tmux send-keys -t "${SESSION}:0.2" "jl" Enter

# 기본 선택 pane을 좌측 pane (인덱스 0)으로 변경
tmux select-pane -t "${SESSION}:0.0"

# tmux 세션에 attach
tmux attach-session -t "$SESSION"

