#!/usr/bin/env bash
set -euo pipefail

ROOT="${ROOT_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
CADENCE_FILE="${ROOT}/docs/transparency/reporting-cadence.md"
MONTHLY_TEMPLATE="${ROOT}/docs/transparency/2026-03-report-template.md"
GENERIC_TEMPLATE="${ROOT}/docs/transparency-report-template.md"

test -f "${CADENCE_FILE}"
test -f "${MONTHLY_TEMPLATE}"
test -f "${GENERIC_TEMPLATE}"

grep -F "## Ownership" "${CADENCE_FILE}" >/dev/null
grep -F "Primary owner: the active admin currently driving that month’s reporting issue." "${CADENCE_FILE}" >/dev/null
grep -F "Backup owner: any other active admin if the primary owner is unavailable by the due date." "${CADENCE_FILE}" >/dev/null
grep -F "## Publication channel" "${CADENCE_FILE}" >/dev/null
grep -F "Publish the final monthly report as a Markdown document under \`docs/transparency/\`." "${CADENCE_FILE}" >/dev/null
grep -F "Link the final report from the reporting-cycle issue for that month." "${CADENCE_FILE}" >/dev/null

grep -F -- "- Primary owner:" "${MONTHLY_TEMPLATE}" >/dev/null
grep -F -- "- Backup owner:" "${MONTHLY_TEMPLATE}" >/dev/null
grep -F -- "- Publication location:" "${MONTHLY_TEMPLATE}" >/dev/null

grep -F -- "- Primary owner:" "${GENERIC_TEMPLATE}" >/dev/null
grep -F -- "- Backup owner:" "${GENERIC_TEMPLATE}" >/dev/null
grep -F -- "- Publication location:" "${GENERIC_TEMPLATE}" >/dev/null

echo "Reporting cadence check passed."
