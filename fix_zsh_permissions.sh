#!/usr/bin/env bash
set -euo pipefail

# ========= 설정 =========
ZSHRC="$HOME/.zshrc"
TS="$(date +%Y%m%d-%H%M%S)"
BACKUP="$ZSHRC.backup.$TS"

# Homebrew 경로 자동 탐지(없으면 Apple Silicon 기본값으로)
if command -v brew >/dev/null 2>&1; then
  BREW_PREFIX="$(brew --prefix)"
else
  BREW_PREFIX="/opt/homebrew"
fi

BREW_ZSH_DIR="$BREW_PREFIX/share/zsh"
BREW_SITE_FUNCS="$BREW_PREFIX/share/zsh/site-functions"

HOME_SITE_FUNCS="$HOME/.zsh/site-functions"

YELLOW='\033[33m'; GREEN='\033[32m'; RED='\033[31m'; RESET='\033[0m'

say() { echo -e "${YELLOW}==>${RESET} $*"; }
ok()  { echo -e "${GREEN}✓${RESET} $*"; }
err() { echo -e "${RED}✗${RESET} $*"; }

need_sudo=false
if [[ -d "$BREW_ZSH_DIR" ]]; then
  need_sudo=true
fi

# ========= 함수들 =========

fix_brew_permissions() {
  if [[ ! -d "$BREW_ZSH_DIR" ]]; then
    say "Homebrew zsh dir not found: $BREW_ZSH_DIR (건너뜀)"
    return 0
  fi

  say "ACL 제거(chmod -RN) 및 권한 표준화(디렉토리 755, 파일 644) 진행..."
  $need_sudo && sudo chmod -RN "$BREW_ZSH_DIR" "$BREW_SITE_FUNCS" 2>/dev/null || true

  $need_sudo && sudo find "$BREW_ZSH_DIR" -type d -exec chmod 755 {} \;
  $need_sudo && sudo find "$BREW_ZSH_DIR" -type f -exec chmod 644 {} \;

  say "소유권을 $USER:staff 로 통일(문제 없으면 안전)…"
  $need_sudo && sudo chown -R "$USER":staff "$BREW_ZSH_DIR" "$BREW_SITE_FUNCS" 2>/dev/null || true

  ok "Homebrew completion 권한/ACL 기본 정리 완료"
}

rebuild_compdump() {
  say "기존 ~/.zcompdump* 제거 및 compinit 재생성..."
  rm -f "$HOME"/.zcompdump* 2>/dev/null || true
  # 비대화식으로 compinit 호출(정상 시 조용히 끝남)
  zsh -ic 'autoload -Uz compinit; compinit' >/dev/null 2>&1 || true
}

check_compaudit_insecure() {
  # insecure가 하나라도 있으면 1 리턴
  local out
  out="$(zsh -ic 'compaudit' 2>/dev/null || true)"
  if [[ -n "$out" ]]; then
    echo "$out" | grep -q 'insecure ' && return 1
    # 일부 zsh는 "insecure files:" 없이 경로만 나열 -> 비어있지 않으면 불안정으로 처리
    return 1
  fi
  return 0
}

mirror_brew_to_home() {
  say "홈 디렉토리에 안전한 site-functions 미러 생성: $HOME_SITE_FUNCS"
  mkdir -p "$HOME_SITE_FUNCS"
  rsync -a --delete \
    --chmod=Du=rwx,Dgo=rx,Fu=rw,Fgo=r \
    "$BREW_SITE_FUNCS"/ \
    "$HOME_SITE_FUNCS"/
  ok "미러 완료"
}

ensure_zshrc_backup() {
  cp "$ZSHRC" "$BACKUP"
  ok ".zshrc 백업 생성: $BACKUP"
}

ensure_fpath_and_compinit_block() {
  # .zshrc 맨 위에 손대지 않고, "추가" 블록만 삽입 (중복 방지)
  local marker_begin="# >>> zsh-compinit-fix (managed) >>>"
  local marker_end="# <<< zsh-compinit-fix (managed) <<<"

  if grep -qF "$marker_begin" "$ZSHRC"; then
    ok "관리 블록 이미 존재(중복 추가 안 함)"
    return 0
  fi

  say ".zshrc 상단에 안전한 fpath/compinit 블록 추가(원본 주석/내용 보존)"
  {
    echo "$marker_begin"
    echo 'fpath=("$HOME/.zsh/site-functions" "${fpath[@]/\/opt\/homebrew\/share\/zsh\/site-functions/}")'
    echo 'if [[ -z ${__COMPINIT_FIXED_ALREADY+x} ]]; then'
    echo '  typeset -g __COMPINIT_FIXED_ALREADY=1'
    echo '  autoload -Uz compinit'
    echo '  compinit'
    echo 'fi'
    echo "$marker_end"
    echo
    cat "$ZSHRC"
  } > "$ZSHRC.tmp" && mv "$ZSHRC.tmp" "$ZSHRC"

  ok "관리 블록 추가 완료"
}

# ========= 실행 =========
if [[ ! -f "$ZSHRC" ]]; then
  err "파일이 없습니다: $ZSHRC"
  exit 1
fi

ensure_zshrc_backup

say "1) Homebrew completion 권한/ACL 정리 시도"
fix_brew_permissions
rebuild_compdump

say "2) compaudit 검사"
if check_compaudit_insecure; then
  ok "compaudit: 문제 없음"
else
  err "compaudit: 여전히 insecure 항목 감지됨 → 안전 미러 방식으로 전환"
  mirror_brew_to_home
  ensure_fpath_and_compinit_block
  rebuild_compdump
fi

say "최종 compaudit 재검사"
if check_compaudit_insecure; then
  ok "정상: insecure 없음"
else
  err "여전히 insecure가 감지됩니다."
  echo "다음 명령으로 ACL/권한을 직접 확인하세요:"
  echo "  ls -ldeO $BREW_PREFIX $BREW_PREFIX/share $BREW_PREFIX/share/zsh $BREW_PREFIX/share/zsh/site-functions"
  echo "  ls -leO  $BREW_PREFIX/share/zsh/site-functions/_brew"
  echo "ACL(+) 가 보이면: sudo chmod -N <경로> 로 제거 후 재실행"
fi

ok "완료. 새 터미널을 열어 동작을 확인하세요."

