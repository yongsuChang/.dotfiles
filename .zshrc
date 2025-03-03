# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# secretive
export SSH_AUTH_SOCK=/Users/chang-yongsu/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

# Basic configs
# History
setopt EXTENDED_HISTORY HIST_IGNORE_ALL_DUPS HIST_LEX_WORDS HIST_REDUCE_BLANKS SHARE_HISTORY
HISTSIZE=9000000
SAVEHIST="${HISTSIZE}"
HISTFILE=~/.zsh_history

#
# Load local configs
#
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi

setopt AUTO_CD
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
# Substring completion
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

#
# zsh-substring-completion
#
setopt complete_in_word
setopt always_to_end
WORDCHARS=''
zmodload -i zsh/complist

# IntelliJ GUI 사용 금지
export AWT_TOOLKIT=MToolkit
export _JAVA_AWT_WM_NONREPARENTING=1
export NO_AT_BRIDGE=1

# gradle
export GRADLE_HOME="/usr/share/gradle"
export PATH=$GRADLE_HOME/bin:$PATH

# Shortcuts
## fd-find
alias fd='fdfind'
## lsd
alias ls='lsd'
alias ll='lsd -l'
alias l='lsd -Al'

## git
alias notpush='git log --branches --not --remotes'
alias lg='lazygit'
alias gpull='(cd ~/git/.dotfiles && git pull) && (cd ~/git/life && git pull)'  # dotfiles와 life 프로젝트 pull

## jira
alias jl='jira issue list'  # Jira CLI 명령어 줄임말
alias jlm='jira issue list -q "assignee = currentUser()"'  # Jira CLI 내가 담당한 이슈 목록
alias jlmd='jira issue list -q "assignee = currentUser() AND status != Done"'  # Jira CLI 내가 담당한 진행 중인 이슈 목록
alias jlp='jira issue list -q "assignee = currentUser() AND status != done AND sprint not in (10)"'  # Jira CLI 내가 담당한 진행 중인 이슈 목록

# 프로젝트 빌드 및 실행
alias sii='nohup /opt/idea/bin/idea > /dev/null 2>&1 & disown'   # IntelliJ 실행 (백그라운드 실행)
alias bib='cd ~/git/invoice-care-back && ./gradlew build --refresh-dependencies --no-daemon'
alias blb='cd ~/git/land-contract-back&& ./gradlew build --refresh-dependencies --no-daemon'
alias rib='cd ~/git/invoice-care-back && ./gradlew bootRun --no-daemon'
alias rlb='cd ~/git/land-contract-back && ./gradlew :contract-admin:bootRun --no-daemon'

## utility
### 클립보드 오류시 해결
alias clipboard='{ unset WAYLAND_DISPLAY; unset XDG_RUNTIME_DIR; export XDG_RUNTIME_DIR=/run/user/1000; touch /run/user/1000/wayland-0; chmod 600 /run/user/1000/wayland-0; }'
alias morning='~/.start_work.sh'  # 아침 출근 스크립트

# 배포 관련
deploy() {
  # 프로젝트와 서버 값 제한
  local selectedProject
  local allowedServers=("prod" "prod2" "internal" "staging" "test")
  local projectDir

  # 첫 번째 인자: project
  case $1 in
    admin)
      selectedProject="contract-admin-deploy.yml"
      projectDir="~/git/land-contract-back/contract-admin"
      ;;
    report)
      selectedProject="report-deploy.yml"
      projectDir="~/git/land-contract-back/contract-report"
      ;;
    scheduled)
      selectedProject="scheduled-deploy.yml"
      projectDir="~/git/land-contract-back/contract-scheduled"
      ;;
    *)
      echo "❌ Error: Invalid project '$1'. Allowed: admin, report, scheduled"
      return 1
      ;;
  esac

  # 두 번째 인자: branch
  local branch=$2
  if [ -z "$branch" ]; then
    echo "❌ Error: Branch is required."
    return 1
  fi

  # 세 번째 인자: server
  local server=$3
  if [[ ! " ${allowedServers[@]} " =~ " ${server} " ]]; then
    echo "❌ Error: Invalid server '$server'. Allowed: ${allowedServers[*]}"
    return 1
  fi

  # 최종 확인 메시지
  echo "🔔 ${branch} 브랜치 환경으로 ${1} 프로젝트를 ${server} 서버에 배포하시겠습니까? (Y/n)"
  read -r confirmation

  case $confirmation in
    [Yy]*)
      echo "🚀 Deploying ${selectedProject} to ${server} with branch ${branch}..."

      # 디렉토리에서 명령 실행
      (cd ${projectDir/#\~/$HOME} && gh workflow run "${selectedProject}" --ref "${branch}" --field server="${server}")
      ;;
    [Nn]*)
      echo "🛑 Deployment canceled."
      ;;
    *)
      echo "❌ Invalid input. Deployment canceled."
      ;;
  esac
}

dbclone() {
  local schema=$1

  # 한글 메시지 및 스타일 정의
  local SUCCESS_ICON="✅"
  local ERROR_ICON="❌"
  local INFO_ICON="ℹ️"
  local STEP_ICON="➡️"

  # 스키마와 프로젝트 입력 확인
  if [[ -z "$schema" ]]; then
    echo "${ERROR_ICON} 사용법: dbclone <스키마 이름> "
    return 1
  fi

  # 프로젝트 값에 따라 pass 명령어로 동적 값 가져오기
  local password=$(pass show DB_PRODUCT_PASSWORD)
  local addressProduct=$(pass show DB_PRODUCT_URL)
  local addressTest=$(pass show DB_TEST_URL)
  local portProduct="3306"
  local portTest="3307"

  # pass 명령어 실패 시 처리
  if [[ -z "$password" || -z "$addressProduct" || -z "$addressTest" ]]; then
    echo "${ERROR_ICON} 'pass' 명령어를 통해 DB 정보를 가져오는 데 실패했습니다."
    return 1
  fi

  # 임시 경로 설정
  local temp_path=~/temp/${schema}.sql

  echo "${INFO_ICON} 스키마 클론 작업을 시작합니다."
  echo "${STEP_ICON} 스키마 이름: ${schema}"
  echo "${STEP_ICON} 원본 DB 주소: ${addressProduct}"
  echo "${STEP_ICON} 원본 포트: ${portProduct}"
  echo "${STEP_ICON} 복사 DB 주소: ${addressTest}"
  echo "${STEP_ICON} 복사 포트: ${portTest}"
  echo "${STEP_ICON} 임시 경로: ${temp_path}"
  echo ""

  # 1. 스키마 덤프
  echo "${INFO_ICON} 스키마를 덤프 중입니다..."
  mariadb-dump -h $addressProduct -P $portProduct -u ssingeat -p$password contract > $temp_path
  if [[ $? -ne 0 ]]; then
    echo "${ERROR_ICON} 스키마 덤프 실패: ${schema}"
    return 1
  fi
  echo "${SUCCESS_ICON} 스키마 덤프 완료: ${temp_path}"

  # Collation 변환
  echo "${INFO_ICON} 덤프 파일에서 collation 변환 중..."
  sed -i 's/utf8mb4_0900_ai_ci/utf8mb4_general_ci/g' $temp_path
  echo "${SUCCESS_ICON} collation 변환 완료"

  # 2. 새 데이터베이스 생성
  echo "${INFO_ICON} 새로운 데이터베이스를 생성 중입니다..."
  mariadb -h $addressTest -P $portTest -u ssingeat -p$password -e "CREATE DATABASE ${schema};"
  if [[ $? -ne 0 ]]; then
    echo "${ERROR_ICON} 데이터베이스 생성 실패: ${schema}"
    return 1
  fi
  echo "${SUCCESS_ICON} 데이터베이스 생성 완료: ${schema}"

  # 3. 덤프 파일 복원
  echo "${INFO_ICON} 스키마를 복원 중입니다..."
  mariadb -h $addressTest -P $portTest -u ssingeat -p$password ${schema} < $temp_path
  if [[ $? -ne 0 ]]; then
    echo "${ERROR_ICON} 스키마 복원 실패: ${schema}"
    return 1
  fi
  echo "${SUCCESS_ICON} 스키마 복원 완료: ${schema}"

  echo ""
  echo "${SUCCESS_ICON} 데이터베이스 클론 작업이 성공적으로 완료되었습니다!"
}

export TERM=xterm-256color
export PATH=$PATH:$HOME/go/bin
export EDITOR=nvim
bindkey -e # Use emacs keybinding yet EDITOR is nvim

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

#
# zinit
#
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
  command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
  command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
    print -P "%F{33} %F{34}Installation successful.%f%b" || \
    print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light simnalamburt/cgitc
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions

# zsh-autosuggestions
ZSH_AUTOSUGGEST_USE_ASYNC=1
if is-at-least 5.3; then
  zinit ice silent wait'1' atload'_zsh_autosuggest_start'
fi
zinit light zsh-users/zsh-autosuggestions

# zsh-expand-all
ZSH_EXPAND_ALL_DISABLE=word
zinit light simnalamburt/zsh-expand-all

# fzf
zi ice from"gh-r" as"program"
zi light junegunn/fzf
source <(fzf --zsh)

# zsh-history-substring-search
zinit light zsh-users/zsh-history-substring-search
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

autoload -Uz compinit
compinit


#
# Load local configs
#
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
