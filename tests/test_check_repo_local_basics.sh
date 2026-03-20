#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHECK_SCRIPT="${REPO_ROOT}/scripts/check_repo_local_basics.sh"

assert_fails() {
  if "$@"; then
    echo "expected failure but command succeeded: $*" >&2
    exit 1
  fi
}

mk_case_dir() {
  mktemp -d "${TMPDIR:-/tmp}/gov-repo-local-basics-test.XXXXXX"
}

write_valid_case() {
  local dir="$1"
  mkdir -p "${dir}/docs"

  cat >"${dir}/.gitignore" <<'EOF'
.Jimmy/
private/
.env
EOF

  cat >"${dir}/README.md" <<'EOF'
# Governance

- Short project description (`docs/project-purpose.md`)
EOF

  cat >"${dir}/docs/project-purpose.md" <<'EOF'
# What We Are Trying to Do

Short purpose text.
EOF
}

main() {
  local d1 d2

  d1="$(mk_case_dir)"
  write_valid_case "${d1}"
  ROOT_DIR="${d1}" bash "${CHECK_SCRIPT}"

  d2="$(mk_case_dir)"
  write_valid_case "${d2}"
  cat >"${d2}/.gitignore" <<'EOF'
.Jimmy/
.env
EOF
  assert_fails env ROOT_DIR="${d2}" bash "${CHECK_SCRIPT}"

  ROOT_DIR="${REPO_ROOT}" bash "${CHECK_SCRIPT}"

  rm -rf "${d1}" "${d2}"
  echo "check_repo_local_basics tests passed."
}

main "$@"
