#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHECK_SCRIPT="${REPO_ROOT}/scripts/check_orientation_docs.sh"

assert_fails() {
  if "$@"; then
    echo "expected failure but command succeeded: $*" >&2
    exit 1
  fi
}

mk_case_dir() {
  mktemp -d "${TMPDIR:-/tmp}/gov-orientation-docs-test.XXXXXX"
}

write_valid_case() {
  local dir="$1"
  mkdir -p "${dir}/docs"

  cat >"${dir}/README.md" <<'EOF'
# Governance

- Orientation guide (`docs/getting-oriented.md`)
- Glossary (`docs/glossary.md`)
EOF

  cat >"${dir}/GOVERNANCE.md" <<'EOF'
# Governance

Need the short version first? Start with `docs/getting-oriented.md` and `docs/glossary.md`.
EOF

  cat >"${dir}/docs/getting-oriented.md" <<'EOF'
# Getting Oriented

If text is merged but not ratified yet, treat it as merged draft text, not as a fully recorded governance decision.
EOF

  cat >"${dir}/docs/glossary.md" <<'EOF'
# Governance Glossary

Current bootstrap quorum is 2 active admins.

During the bootstrap phase, this can live in the repo under `docs/transparency/ledger/` until an external provider is adopted.
EOF
}

main() {
  local d1 d2 d3

  d1="$(mk_case_dir)"
  write_valid_case "${d1}"
  ROOT_DIR="${d1}" bash "${CHECK_SCRIPT}"

  d2="$(mk_case_dir)"
  write_valid_case "${d2}"
  rm -f "${d2}/docs/getting-oriented.md"
  assert_fails env ROOT_DIR="${d2}" bash "${CHECK_SCRIPT}"

  d3="$(mk_case_dir)"
  write_valid_case "${d3}"
  sed -i '' '/Glossary/d' "${d3}/README.md" 2>/dev/null || \
    sed -i '/Glossary/d' "${d3}/README.md"
  assert_fails env ROOT_DIR="${d3}" bash "${CHECK_SCRIPT}"

  rm -rf "${d1}" "${d2}" "${d3}"
  echo "check_orientation_docs tests passed."
}

main "$@"
