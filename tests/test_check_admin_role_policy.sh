#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHECK_SCRIPT="${REPO_ROOT}/scripts/check_admin_role_policy.sh"

assert_fails() {
  if "$@"; then
    echo "expected failure but command succeeded: $*" >&2
    exit 1
  fi
}

mk_case_dir() {
  mktemp -d "${TMPDIR:-/tmp}/gov-admin-role-policy-test.XXXXXX"
}

write_valid_case() {
  local dir="$1"
  mkdir -p "${dir}/docs/governance"
  cat >"${dir}/GOVERNANCE.md" <<'EOF'
# Governance

## Admin structure

- Canonical policy: `docs/governance/admin-role-and-removal.md`.
- Admins share the same baseline authority in the bootstrap phase.
- Admin membership changes require public record and 2-admin approval.
- The admin under review does not count toward quorum or required approvals for their own restriction or removal.
EOF
  cat >"${dir}/docs/governance/admin-role-and-removal.md" <<'EOF'
# Admin Roles, Limits, and Removal (Draft v1)

Bootstrap choice: Model B. Use a flat admin group with shared baseline authority, explicit multi-admin requirements for sensitive actions, and public recordkeeping for admin membership changes.

## Multi-admin requirements

- granting admin access
- restricting, suspending, or removing admin access through the normal process

Default response window for non-emergency removal or restriction decisions is 7 days.

Emergency restriction does not by itself settle permanent removal.
EOF
}

main() {
  local d1 d2 d3 d4

  d1="$(mk_case_dir)"
  write_valid_case "${d1}"
  ROOT_DIR="${d1}" bash "${CHECK_SCRIPT}"

  d2="$(mk_case_dir)"
  write_valid_case "${d2}"
  rm -f "${d2}/docs/governance/admin-role-and-removal.md"
  assert_fails env ROOT_DIR="${d2}" bash "${CHECK_SCRIPT}"

  d3="$(mk_case_dir)"
  write_valid_case "${d3}"
  sed -i '' 's/Admin membership changes require public record and 2-admin approval./Admin membership changes may be done by one admin./' "${d3}/GOVERNANCE.md" 2>/dev/null || \
    sed -i 's/Admin membership changes require public record and 2-admin approval./Admin membership changes may be done by one admin./' "${d3}/GOVERNANCE.md"
  assert_fails env ROOT_DIR="${d3}" bash "${CHECK_SCRIPT}"

  d4="$(mk_case_dir)"
  write_valid_case "${d4}"
  sed -i '' 's/Default response window for non-emergency removal or restriction decisions is 7 days./Default response window for non-emergency removal or restriction decisions is 1 day./' "${d4}/docs/governance/admin-role-and-removal.md" 2>/dev/null || \
    sed -i 's/Default response window for non-emergency removal or restriction decisions is 7 days./Default response window for non-emergency removal or restriction decisions is 1 day./' "${d4}/docs/governance/admin-role-and-removal.md"
  assert_fails env ROOT_DIR="${d4}" bash "${CHECK_SCRIPT}"

  rm -rf "${d1}" "${d2}" "${d3}" "${d4}"
  echo "check_admin_role_policy tests passed."
}

main "$@"
