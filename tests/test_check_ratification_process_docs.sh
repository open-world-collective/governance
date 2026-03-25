#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHECK_SCRIPT="${REPO_ROOT}/scripts/check_ratification_process_docs.sh"

assert_fails() {
  if "$@"; then
    echo "expected failure but command succeeded: $*" >&2
    exit 1
  fi
}

mk_case_dir() {
  mktemp -d "${TMPDIR:-/tmp}/gov-ratification-doc-test.XXXXXX"
}

write_valid_case() {
  local dir="$1"
  mkdir -p "${dir}/docs/governance"

  cat >"${dir}/README.md" <<'EOF'
# Governance
- [Ratification approval packet](docs/governance/ratification-approval-packet.md)
EOF

  cat >"${dir}/docs/governance/policy-change-process.md" <<'EOF'
# Policy Change Process (Draft v1)
For a reusable approval-comment format, see `docs/governance/ratification-approval-packet.md`.
3. **Decide**: admins vote per `docs/governance/roles-and-voting.md` (quorum of at least 2 active admins).
   - When requesting ratification on GitHub, post a clear approval packet and `@mention` the admins whose approval is needed.
   - Include `@qarl` on ratification requests so the approval thread is visible to the repo lead.
   - If there are pending admins with known GitHub usernames, `@mention` them for visibility, but do not count their comments toward quorum until they accept the invite.
   - If quorum has not been reached by the next day, post a plain-English follow-up summary and `@mention` only the admins who still have not responded.
EOF

  cat >"${dir}/docs/governance/ratification-approval-packet.md" <<'EOF'
# Ratification Approval Packet
### 6. Delivery and notification
- `@mention` the admins whose approval is needed so GitHub sends a notification
- include `@qarl` on ratification requests
- pending-admin comments do not count toward approval quorum until the invite is accepted
### 7. Next-day follow-up
- post a short follow-up comment in plainer English
EOF
}

main() {
  local d1 d2

  d1="$(mk_case_dir)"
  write_valid_case "${d1}"
  ROOT_DIR="${d1}" bash "${CHECK_SCRIPT}"

  d2="$(mk_case_dir)"
  write_valid_case "${d2}"
  sed -i '' 's/include `@qarl` on ratification requests/include admin mentions/' "${d2}/docs/governance/ratification-approval-packet.md" 2>/dev/null || \
    sed -i 's/include `@qarl` on ratification requests/include admin mentions/' "${d2}/docs/governance/ratification-approval-packet.md"
  assert_fails env ROOT_DIR="${d2}" bash "${CHECK_SCRIPT}"

  ROOT_DIR="${REPO_ROOT}" bash "${CHECK_SCRIPT}"

  rm -rf "${d1}" "${d2}"
  echo "check_ratification_process_docs tests passed."
}

main "$@"
