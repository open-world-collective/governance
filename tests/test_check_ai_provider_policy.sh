#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHECK_SCRIPT="${REPO_ROOT}/scripts/check_ai_provider_policy.sh"

assert_fails() {
  if "$@"; then
    echo "expected failure but command succeeded: $*" >&2
    exit 1
  fi
}

mk_case_dir() {
  mktemp -d "${TMPDIR:-/tmp}/gov-ai-policy-test.XXXXXX"
}

write_valid_case() {
  local dir="$1"
  cat >"${dir}/README.md" <<'EOF'
# Governance
See [AI_PROVIDER_POLICY.md](AI_PROVIDER_POLICY.md).
EOF
  cat >"${dir}/AI_PROVIDER_POLICY.md" <<'EOF'
# AI Provider Policy
mass domestic surveillance
fully autonomous weaponization
Approved: Anthropic
Not approved: OpenAI
EOF
}

main() {
  local d1 d2 d3

  d1="$(mk_case_dir)"
  write_valid_case "${d1}"
  ROOT_DIR="${d1}" bash "${CHECK_SCRIPT}"

  d2="$(mk_case_dir)"
  cat >"${d2}/README.md" <<'EOF'
# Governance
See [AI_PROVIDER_POLICY.md](AI_PROVIDER_POLICY.md).
EOF
  assert_fails env ROOT_DIR="${d2}" bash "${CHECK_SCRIPT}"

  d3="$(mk_case_dir)"
  write_valid_case "${d3}"
  sed -i '' 's/Not approved: OpenAI/Not approved: ExampleAI/' "${d3}/AI_PROVIDER_POLICY.md" 2>/dev/null || \
    sed -i 's/Not approved: OpenAI/Not approved: ExampleAI/' "${d3}/AI_PROVIDER_POLICY.md"
  assert_fails env ROOT_DIR="${d3}" bash "${CHECK_SCRIPT}"

  # Repo-level smoke checks for governance docs touched by rollups.
  test -s "${REPO_ROOT}/docs/agent-runbook.md"
  test -s "${REPO_ROOT}/docs/charter.md"
  test -s "${REPO_ROOT}/docs/roadmap/phases.md"
  if grep -R -n "jimmy-minecraft-worker" "${REPO_ROOT}/docs/agent-runbook.md" "${REPO_ROOT}/docs/charter.md" "${REPO_ROOT}/docs/roadmap/phases.md" >/dev/null 2>&1; then
    echo "deprecated worker label found in governance docs" >&2
    exit 1
  fi

  rm -rf "${d1}" "${d2}" "${d3}"
  echo "check_ai_provider_policy tests passed."
}

main "$@"
