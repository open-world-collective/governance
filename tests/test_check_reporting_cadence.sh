#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHECK_SCRIPT="${REPO_ROOT}/scripts/check_reporting_cadence.sh"

assert_fails() {
  if "$@"; then
    echo "expected failure but command succeeded: $*" >&2
    exit 1
  fi
}

mk_case_dir() {
  mktemp -d "${TMPDIR:-/tmp}/gov-reporting-cadence-test.XXXXXX"
}

write_valid_case() {
  local dir="$1"
  mkdir -p "${dir}/docs/transparency"

  cat >"${dir}/docs/transparency/reporting-cadence.md" <<'EOF'
# Transparency Reporting Cadence

## Monthly report

- Frequency: once per month.
- Target publish date: by the 7th day of the following month.
- Template: `docs/transparency/2026-03-report-template.md` (or latest monthly variant).
- Public ledger policy: `docs/transparency/public-ledger-policy.md`.

## Ownership

- Primary owner: the active admin currently driving that month’s reporting issue.
- Backup owner: any other active admin if the primary owner is unavailable by the due date.
- If no owner is obvious, record the acting owner in the reporting-cycle issue before the report is published.

## Publication channel

- Publish the final monthly report as a Markdown document under `docs/transparency/`.
- Link the final report from the reporting-cycle issue for that month.
- If the report is delayed or partially empty, publish the best available version anyway and note the gap explicitly.
EOF

  cat >"${dir}/docs/transparency/2026-03-report-template.md" <<'EOF'
# Transparency Report Template (Monthly)

## Reporting period

- Start:
- End:
- Primary owner:
- Backup owner:
- Publication location:
EOF

  cat >"${dir}/docs/transparency-report-template.md" <<'EOF'
# Transparency Report Template

## Period

- Start:
- End:
- Primary owner:
- Backup owner:
- Publication location:
EOF
}

main() {
  local d1 d2 d3

  d1="$(mk_case_dir)"
  write_valid_case "${d1}"
  ROOT_DIR="${d1}" bash "${CHECK_SCRIPT}"

  d2="$(mk_case_dir)"
  write_valid_case "${d2}"
  sed -i '' '/## Ownership/,+3d' "${d2}/docs/transparency/reporting-cadence.md" 2>/dev/null || \
    sed -i '/## Ownership/,+3d' "${d2}/docs/transparency/reporting-cadence.md"
  assert_fails env ROOT_DIR="${d2}" bash "${CHECK_SCRIPT}"

  d3="$(mk_case_dir)"
  write_valid_case "${d3}"
  sed -i '' '/Publication location/d' "${d3}/docs/transparency/2026-03-report-template.md" 2>/dev/null || \
    sed -i '/Publication location/d' "${d3}/docs/transparency/2026-03-report-template.md"
  assert_fails env ROOT_DIR="${d3}" bash "${CHECK_SCRIPT}"

  rm -rf "${d1}" "${d2}" "${d3}"
  echo "check_reporting_cadence tests passed."
}

main "$@"
