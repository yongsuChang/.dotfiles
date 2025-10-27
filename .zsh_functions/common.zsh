# ===== Swap helpers ==========================================================
# 사용법:
#   enable_swap [SIZE_MB] [SWAPFILE_PATH]
#     예) enable_swap           # 2048MB를 /mnt/swapfile로 생성
#         enable_swap 4096      # 4096MB를 /mnt/swapfile로 생성
#         enable_swap 1024 /swapfile
#
#   disable_swap [SWAPFILE_PATH]
#     예) disable_swap          # /mnt/swapfile 비활성화 및 삭제
#         disable_swap /swapfile

enable_swap() {
  local size_mb="${1:-2048}"
  local swapfile="${2:-/mnt/swapfile}"

  echo "ℹ️  현재 스왑 상태:"
  sudo swapon --show || true
  echo

  if [[ -f "$swapfile" ]]; then
    echo "⚠️  스왑 파일이 이미 존재합니다: $swapfile"
  fi

  # 이미 어떤 스왑이든 활성화되어 있는지 안내
  if sudo swapon --show | grep -q . ; then
    echo "⚠️  현재 활성화된 스왑이 있습니다."
  fi

  echo "🔔 ${size_mb}MB 크기의 스왑을 '${swapfile}' 경로에 생성/활성화 하시겠습니까? (Y/n)"
  read -r ans
  case "$ans" in
    [Nn]* ) echo "🛑 작업을 취소했습니다."; return 1 ;;
  esac

  # 생성
  echo "🧱 스왑 파일 생성 중: $swapfile (${size_mb}MB)"
  sudo dd if=/dev/zero of="$swapfile" bs=1M count="$size_mb" status=progress
  sudo chmod 600 "$swapfile"
  sudo mkswap "$swapfile"
  sudo swapon "$swapfile"

  echo
  echo "✅ 스왑 활성화 완료. 현재 상태:"
  sudo swapon --show
}

disable_swap() {
  local swapfile="${1:-/mnt/swapfile}"

  echo "ℹ️  현재 스왑 상태:"
  sudo swapon --show || true
  echo

  if [[ ! -f "$swapfile" ]]; then
    echo "⚠️  지정한 스왑 파일이 존재하지 않습니다: $swapfile"
    echo "   그래도 스왑 비활성화를 시도할까요? (Y/n)"
    read -r cont
    case "$cont" in
      [Nn]* ) echo "🛑 작업을 취소했습니다."; return 1 ;;
    esac
  else
    echo "🔔 '${swapfile}' 스왑을 비활성화하고 파일을 삭제합니다. 진행하시겠습니까? (Y/n)"
    read -r ans
    case "$ans" in
      [Nn]* ) echo "🛑 작업을 취소했습니다."; return 1 ;;
    esac
  fi

  echo "🧹 스왑 비활성화 중: $swapfile"
  sudo swapoff "$swapfile" 2>/dev/null || true

  echo "🗑️  스왑 파일 삭제 중: $swapfile"
  sudo rm -f "$swapfile"

  echo
  echo "✅ 스왑 비활성화/삭제 완료. 현재 상태:"
  sudo swapon --show || true
}
# ============================================================================
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
    echo "${ERROR_ICON} 사용법: dbclone <스키마 이름>"
    return 1
  fi

  # DB 연결 정보
  local password="$DB_PRODUCT_PASSWORD"
  local addressProduct="$DB_PRODUCT_URL"
  local addressTest="$DB_TEST_URL"
  local portProduct="3306"
  local portTest="3307"

  if [[ -z "$password" || -z "$addressProduct" || -z "$addressTest" ]]; then
    echo "${ERROR_ICON} 'pass' 명령어를 통해 DB 정보를 가져오는 데 실패했습니다."
    return 1
  fi

  # 임시 경로 설정
  local temp_path=~/temp/${schema}.sql

  echo "${INFO_ICON} 스키마 클론 작업을 시작합니다."
  echo "${STEP_ICON} 스키마 이름: ${schema}"
  echo "${STEP_ICON} 원본 DB 주소: ${addressProduct}"
  echo "${STEP_ICON} 복사 DB 주소: ${addressTest}"
  echo "${STEP_ICON} 임시 경로: ${temp_path}"
  echo ""

  # ✅ OS 감지 (Mac vs Windows/WSL)
  local SED_OPTION=""
  local SSL_OPTION=""
  if [[ "$(uname)" == "Darwin" ]]; then
    echo "${INFO_ICON} Mac 환경 감지됨"
    SED_OPTION="-i ''"
    SSL_OPTION="--ssl=OFF"
  elif [[ "$(uname -r)" == *"microsoft"* ]]; then
    echo "${INFO_ICON} Windows WSL 환경 감지됨"
    SED_OPTION="-i"
    SSL_OPTION=""
  fi

  # 1. 스키마 덤프
  echo "${INFO_ICON} 스키마를 덤프 중입니다..."
  mariadb-dump -h $addressProduct -P $portProduct -u ssingeat -p$password $SSL_OPTION contract > $temp_path
  if [[ $? -ne 0 ]]; then
    echo "${ERROR_ICON} 스키마 덤프 실패: ${schema}"
    return 1
  fi
  echo "${SUCCESS_ICON} 스키마 덤프 완료: ${temp_path}"

  # Collation 변환
  echo "${INFO_ICON} 덤프 파일에서 collation 변환 중..."
  sed $SED_OPTION 's/utf8mb4_0900_ai_ci/utf8mb4_general_ci/g' $temp_path
  echo "${SUCCESS_ICON} collation 변환 완료"

  # 2. 새 데이터베이스 생성
  echo "${INFO_ICON} 새로운 데이터베이스를 생성 중입니다..."
  mariadb -h $addressTest -P $portTest -u ssingeat -p$password --ssl --ssl-verify-server-cert=OFF -e "CREATE DATABASE ${schema};"
  if [[ $? -ne 0 ]]; then
    echo "${ERROR_ICON} 데이터베이스 생성 실패: ${schema}"
    return 1
  fi
  echo "${SUCCESS_ICON} 데이터베이스 생성 완료: ${schema}"

  # 3. 덤프 파일 복원
  echo "${INFO_ICON} 스키마를 복원 중입니다..."
  mariadb -h $addressTest -P $portTest -u ssingeat -p$password --ssl --ssl-verify-server-cert=OFF ${schema} < $temp_path
  if [[ $? -ne 0 ]]; then
    echo "${ERROR_ICON} 스키마 복원 실패: ${schema}"
    return 1
  fi
  echo "${SUCCESS_ICON} 스키마 복원 완료: ${schema}"
}

