#!/usr/bin/env bash
set -euo pipefail

ROOT="${ROOT_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
cd "${ROOT}"

POLICY_PATH="docs/transparency/public-ledger-policy.md"
LEDGER_INDEX="docs/transparency/ledger/index.md"
LEDGER_MONTH_MD="docs/transparency/ledger/2026-03.md"
LEDGER_MONTH_CSV="docs/transparency/ledger/2026-03.csv"
REPORT_TEMPLATE="docs/transparency/2026-03-report-template.md"

test -f "${POLICY_PATH}"
test -f "${LEDGER_INDEX}"
test -f "${LEDGER_MONTH_MD}"
test -f "${LEDGER_MONTH_CSV}"

grep -F "canonical public ledger may live in this repository under \`docs/transparency/ledger/\`." "${POLICY_PATH}" >/dev/null
grep -F "If a reporting period has no transactions, the report should still link the relevant monthly ledger file and say explicitly that no transactions were recorded." "${POLICY_PATH}" >/dev/null
grep -F "Current provider status: no external ledger provider is active yet." "${LEDGER_INDEX}" >/dev/null
grep -F -- "- \`YYYY-MM.md\` — human-readable monthly ledger view" "${LEDGER_INDEX}" >/dev/null
grep -F "No public-ledger transactions recorded during this reporting period." "${LEDGER_MONTH_MD}" >/dev/null
grep -F "entry_id,date,amount,currency,payee_label,category,purpose,approval_ref,receipt_ref,variance_note,status" "${LEDGER_MONTH_CSV}" >/dev/null
grep -F -- "- Monthly ledger file:" "${REPORT_TEMPLATE}" >/dev/null

echo "Public ledger bootstrap check passed."
