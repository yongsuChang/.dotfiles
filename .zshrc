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
alias v=nvim
alias vi=nvim
alias vim=nvim
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
alias clipboard='{ unset WAYLAND_DISPLAY; unset XDG_RUNTIME_DIR; export XDG_RUNTIME_DIR=/run/user/1000; touch /run/user/1000/wayland-0; chmod 600 /run/user/1000/wayland-0; }' # 클립보드 오류시 해결
alias morning='~/.start_work.sh'  # 아침 출근 스크립트
alias claude='pnpx @anthropic-ai/claude-code' # Claude Code 실행

# 공통 함수 불러오기
source ~/.zsh_functions/common.zsh

# 운영체제별 함수 적용
if [[ "$(uname)" == "Darwin" ]]; then
  source ~/.zsh_functions/mac.zsh
elif [[ "$(uname -r)" == *"microsoft"* ]]; then
  source ~/.zsh_functions/windows.zsh
fi

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

