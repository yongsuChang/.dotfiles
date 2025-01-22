# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# pnpm
export PNPM_HOME="/home/yongsu/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

#
# Personal configs
#
alias ls='lsd'
alias ll='lsd -l'
alias l='lsd -Al'
alias notpush='git log --branches --not --remotes'

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
    *)
      echo "❌ Error: Invalid project '$1'. Allowed: admin, report"
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

# zshrc에 alias 추가
alias deploy="deploy"
