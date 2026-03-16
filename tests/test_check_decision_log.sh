#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHECK_SCRIPT="${REPO_ROOT}/scripts/check_decision_log.sh"

assert_fails() {
  if "$@"; then
    echo "expected failure but command succeeded: $*" >&2
    exit 1
  fi
}

mk_case_dir() {
  mktemp -d "${TMPDIR:-/tmp}/gov-decision-log-test.XXXXXX"
}

write_valid_case() {
  local dir="$1"
  mkdir -p "${dir}/docs"
  cat >"${dir}/docs/decision-log.md" <<'EOF'
# Decision Log

Use this log for governance or financial-control decisions.

## Entries

- 2026-02-28 | GOV-001 | Created governance repository and bootstrap docs. | Bootstrap phase for early public collaboration readiness. | Govern via admin majority with documented decisions. | open-world-collective admins | Seed governance roadmap issues.
- 2026-03-16 | GOV-002 | Ratified bootstrap governance repo scope. | Needed a public statement of what belongs in this repo versus technical repos after docs/scope.md landed in PR #12. | Adopt docs/scope.md as the bootstrap scope definition for the governance repo. | qarl, Sniffleupagus (via issue #1 approvals) | Keep scope links aligned across README, governance docs, and future technical-repo policy references; links: issue #1, PR #12; recusals: none.
- 2026-03-16 | GOV-003 | Ratified public-ledger transparency policy. | Needed explicit public-ledger rules for metadata, approval links, redaction boundaries, and monthly reconciliation after docs/transparency/public-ledger-policy.md landed in PR #13. | Adopt docs/transparency/public-ledger-policy.md as the bootstrap public-ledger transparency policy. | qarl, makingentropy (via issue #5 approvals) | Use the updated ledger/reporting docs for the March 2026 transparency report and keep ledger links aligned with approval records; links: issue #5, PR #13; recusals: none.
EOF
}

main() {
  local d1 d2 d3

  d1="$(mk_case_dir)"
  write_valid_case "${d1}"
  ROOT_DIR="${d1}" bash "${CHECK_SCRIPT}"

  d2="$(mk_case_dir)"
  mkdir -p "${d2}/docs"
  cat >"${d2}/docs/decision-log.md" <<'EOF'
# Decision Log

## Entries

- 2026-03-16 | GOV-001 | Missing fields entry.
EOF
  assert_fails env ROOT_DIR="${d2}" bash "${CHECK_SCRIPT}"

  d3="$(mk_case_dir)"
  mkdir -p "${d3}/docs"
  cat >"${d3}/docs/decision-log.md" <<'EOF'
# Decision Log

## Entries

- 2026-02-28 | GOV-001 | First entry. | Context. | Decision. | Admins. | Follow-up.
- 2026-03-16 | GOV-001 | Duplicate id. | Context. | Decision. | Admins. | Follow-up.
EOF
  assert_fails env ROOT_DIR="${d3}" bash "${CHECK_SCRIPT}"

  ROOT_DIR="${REPO_ROOT}" bash "${CHECK_SCRIPT}"
  grep -F "GOV-002" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "issue #1, PR #12" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "GOV-003" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "issue #5, PR #13" "${REPO_ROOT}/docs/decision-log.md" >/dev/null

  rm -rf "${d1}" "${d2}" "${d3}"
  echo "check_decision_log tests passed."
}

main "$@"
