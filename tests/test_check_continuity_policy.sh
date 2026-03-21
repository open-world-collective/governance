#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHECK_SCRIPT="${REPO_ROOT}/scripts/check_continuity_policy.sh"

assert_fails() {
  if "$@"; then
    echo "expected failure but command succeeded: $*" >&2
    exit 1
  fi
}

mk_case_dir() {
  mktemp -d "${TMPDIR:-/tmp}/gov-continuity-policy-test.XXXXXX"
}

write_valid_case() {
  local dir="$1"
  mkdir -p "${dir}/docs/governance"
  cat >"${dir}/GOVERNANCE.md" <<'EOF'
# Governance

## Continuity and succession

- Canonical policy: `docs/governance/continuity-and-succession.md`.

## Conflicts and recusals

- Conflicted admins must disclose and recuse from the affected decision.
EOF
  cat >"${dir}/docs/governance/continuity-and-succession.md" <<'EOF'
# Continuity and Succession (Draft v1)

- Minimum operational target is 2 active admins.
- If active admin coverage drops below 2, only emergency continuity actions should proceed until coverage is restored.

When possible, at least 2 admins should confirm the private runbook is current and usable at least quarterly and after any major service or personnel change.

- At 30 days without response after at least 2 contact attempts across 2 different channels, open a continuity issue and record the contact attempts.

## Actionable checklist

- Verify the private continuity runbook exists and has been reviewed recently.
EOF
}

main() {
  local d1 d2 d3 d4

  d1="$(mk_case_dir)"
  write_valid_case "${d1}"
  ROOT_DIR="${d1}" bash "${CHECK_SCRIPT}"

  d2="$(mk_case_dir)"
  write_valid_case "${d2}"
  rm -f "${d2}/docs/governance/continuity-and-succession.md"
  assert_fails env ROOT_DIR="${d2}" bash "${CHECK_SCRIPT}"

  d3="$(mk_case_dir)"
  write_valid_case "${d3}"
  sed -i '' 's/Minimum operational target is 2 active admins./Minimum operational target is 1 active admin./' "${d3}/docs/governance/continuity-and-succession.md" 2>/dev/null || \
    sed -i 's/Minimum operational target is 2 active admins./Minimum operational target is 1 active admin./' "${d3}/docs/governance/continuity-and-succession.md"
  assert_fails env ROOT_DIR="${d3}" bash "${CHECK_SCRIPT}"

  d4="$(mk_case_dir)"
  write_valid_case "${d4}"
  sed -i '' '/## Conflicts and recusals/,+2d' "${d4}/GOVERNANCE.md" 2>/dev/null || \
    sed -i '/## Conflicts and recusals/,+2d' "${d4}/GOVERNANCE.md"
  assert_fails env ROOT_DIR="${d4}" bash "${CHECK_SCRIPT}"

  rm -rf "${d1}" "${d2}" "${d3}" "${d4}"
  echo "check_continuity_policy tests passed."
}

main "$@"
