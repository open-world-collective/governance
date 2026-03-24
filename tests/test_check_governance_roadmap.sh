#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHECK_SCRIPT="${REPO_ROOT}/scripts/check_governance_roadmap.sh"

assert_fails() {
  if "$@"; then
    echo "expected failure but command succeeded: $*" >&2
    exit 1
  fi
}

mk_case_dir() {
  mktemp -d "${TMPDIR:-/tmp}/gov-roadmap-test.XXXXXX"
}

write_valid_case() {
  local dir="$1"
  mkdir -p "${dir}/docs/roadmap"
  cat >"${dir}/README.md" <<'EOF'
# Governance

- [Governance roadmap](docs/governance-roadmap.md) and [supporting roadmap notes](docs/roadmap/)
EOF
  cat >"${dir}/docs/governance-roadmap.md" <<'EOF'
# Governance Roadmap (Bootstrap v1)

During the bootstrap phase, review this roadmap monthly.

| Milestone | Goal | Status as of 2026-03-23 | Target review date | Owner | Exit criteria |
| --- | --- | --- | --- | --- | --- |
| M1 Baseline complete | Goal | In progress | 2026-04-07 | Active admins | Criteria |
| M2 Operations routine | Goal | Not started | 2026-06-30 | Active admins | Criteria |
| M3 Participation expansion | Goal | Not started | 2026-09-30 | Active admins | Criteria |

1. ratify `docs/governance/admin-role-and-removal.md` through issue `#2`
EOF
  cat >"${dir}/docs/roadmap/milestones.md" <<'EOF'
# Milestone Plan

Canonical roadmap: `docs/governance-roadmap.md`
EOF
  cat >"${dir}/docs/roadmap/phases.md" <<'EOF'
# Governance Roadmap Phases

Canonical roadmap: `docs/governance-roadmap.md`
EOF
}

main() {
  local d1 d2 d3 d4

  d1="$(mk_case_dir)"
  write_valid_case "${d1}"
  ROOT_DIR="${d1}" bash "${CHECK_SCRIPT}"

  d2="$(mk_case_dir)"
  write_valid_case "${d2}"
  rm -f "${d2}/docs/governance-roadmap.md"
  assert_fails env ROOT_DIR="${d2}" bash "${CHECK_SCRIPT}"

  d3="$(mk_case_dir)"
  write_valid_case "${d3}"
  sed -i '' 's/During the bootstrap phase, review this roadmap monthly./Review this roadmap whenever./' "${d3}/docs/governance-roadmap.md" 2>/dev/null || \
    sed -i 's/During the bootstrap phase, review this roadmap monthly./Review this roadmap whenever./' "${d3}/docs/governance-roadmap.md"
  assert_fails env ROOT_DIR="${d3}" bash "${CHECK_SCRIPT}"

  d4="$(mk_case_dir)"
  write_valid_case "${d4}"
  sed -i '' '/M3 Participation expansion/d' "${d4}/docs/governance-roadmap.md" 2>/dev/null || \
    sed -i '/M3 Participation expansion/d' "${d4}/docs/governance-roadmap.md"
  assert_fails env ROOT_DIR="${d4}" bash "${CHECK_SCRIPT}"

  rm -rf "${d1}" "${d2}" "${d3}" "${d4}"
  echo "check_governance_roadmap tests passed."
}

main "$@"
