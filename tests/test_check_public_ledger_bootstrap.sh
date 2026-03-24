#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHECK_SCRIPT="${REPO_ROOT}/scripts/check_public_ledger_bootstrap.sh"

assert_fails() {
  if "$@"; then
    echo "expected failure but command succeeded: $*" >&2
    exit 1
  fi
}

mk_case_dir() {
  mktemp -d "${TMPDIR:-/tmp}/gov-public-ledger-bootstrap-test.XXXXXX"
}

write_valid_case() {
  local dir="$1"
  mkdir -p "${dir}/docs/transparency/ledger"

  cat >"${dir}/docs/transparency/public-ledger-policy.md" <<'EOF'
# Public Ledger Transparency Policy (Draft v1)

The canonical public ledger may live in this repository under `docs/transparency/ledger/`.

If a reporting period has no transactions, the report should still link the relevant monthly ledger file and say explicitly that no transactions were recorded.
EOF

  cat >"${dir}/docs/transparency/ledger/index.md" <<'EOF'
# Public Ledger Index

Current provider status: no external ledger provider is active yet.

- `YYYY-MM.md` — human-readable monthly ledger view
EOF

  cat >"${dir}/docs/transparency/ledger/2026-03.md" <<'EOF'
# Public Ledger — 2026-03

No public-ledger transactions recorded during this reporting period.
EOF

  cat >"${dir}/docs/transparency/ledger/2026-03.csv" <<'EOF'
entry_id,date,amount,currency,payee_label,category,purpose,approval_ref,receipt_ref,variance_note,status
EOF

  cat >"${dir}/docs/transparency/2026-03-report-template.md" <<'EOF'
# Transparency Report Template (Monthly)

- Monthly ledger file:
EOF
}

main() {
  local d1 d2 d3

  d1="$(mk_case_dir)"
  write_valid_case "${d1}"
  ROOT_DIR="${d1}" bash "${CHECK_SCRIPT}"

  d2="$(mk_case_dir)"
  write_valid_case "${d2}"
  rm -f "${d2}/docs/transparency/ledger/index.md"
  assert_fails env ROOT_DIR="${d2}" bash "${CHECK_SCRIPT}"

  d3="$(mk_case_dir)"
  write_valid_case "${d3}"
  sed -i '' '/Monthly ledger file/d' "${d3}/docs/transparency/2026-03-report-template.md" 2>/dev/null || \
    sed -i '/Monthly ledger file/d' "${d3}/docs/transparency/2026-03-report-template.md"
  assert_fails env ROOT_DIR="${d3}" bash "${CHECK_SCRIPT}"

  rm -rf "${d1}" "${d2}" "${d3}"
  echo "check_public_ledger_bootstrap tests passed."
}

main "$@"
