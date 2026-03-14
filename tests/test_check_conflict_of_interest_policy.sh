#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHECK_SCRIPT="${REPO_ROOT}/scripts/check_conflict_of_interest_policy.sh"

assert_fails() {
  if "$@"; then
    echo "expected failure but command succeeded: $*" >&2
    exit 1
  fi
}

mk_case_dir() {
  mktemp -d "${TMPDIR:-/tmp}/gov-conflict-policy-test.XXXXXX"
}

write_valid_case() {
  local dir="$1"
  mkdir -p "${dir}/docs/governance"
  cat >"${dir}/GOVERNANCE.md" <<'EOF'
# Governance

## Conflicts and recusals

- Canonical policy: `docs/governance/conflict-of-interest.md`.
EOF
  cat >"${dir}/docs/governance/roles-and-voting.md" <<'EOF'
# Roles and Voting (v1)

## Conflict of interest

- Canonical policy: `docs/governance/conflict-of-interest.md`.
EOF
  cat >"${dir}/docs/governance/fund-approval.md" <<'EOF'
# Fund Approval Policy (v1)

## Approval rule

- Conflicts and recusals follow `docs/governance/conflict-of-interest.md`.
EOF
  cat >"${dir}/docs/governance/conflict-of-interest.md" <<'EOF'
# Conflict of Interest and Recusal (Draft v1)

A conflict exists when a reasonable person would question whether someone can act impartially on a specific decision.

- Disclose known conflicts before substantive discussion, recommendation, approval, or vote.
- Use another uninvolved admin whenever possible.
EOF
}

main() {
  local d1 d2 d3

  d1="$(mk_case_dir)"
  write_valid_case "${d1}"
  ROOT_DIR="${d1}" bash "${CHECK_SCRIPT}"

  d2="$(mk_case_dir)"
  write_valid_case "${d2}"
  rm -f "${d2}/docs/governance/conflict-of-interest.md"
  assert_fails env ROOT_DIR="${d2}" bash "${CHECK_SCRIPT}"

  d3="$(mk_case_dir)"
  write_valid_case "${d3}"
  sed -i '' 's/Use another uninvolved admin whenever possible./Use any admin./' "${d3}/docs/governance/conflict-of-interest.md" 2>/dev/null || \
    sed -i 's/Use another uninvolved admin whenever possible./Use any admin./' "${d3}/docs/governance/conflict-of-interest.md"
  assert_fails env ROOT_DIR="${d3}" bash "${CHECK_SCRIPT}"

  rm -rf "${d1}" "${d2}" "${d3}"
  echo "check_conflict_of_interest_policy tests passed."
}

main "$@"
