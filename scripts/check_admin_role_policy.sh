#!/usr/bin/env bash
set -euo pipefail

ROOT="${ROOT_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
cd "${ROOT}"

POLICY_PATH="docs/governance/admin-role-and-removal.md"

test -f "${POLICY_PATH}"
grep -F "Canonical policy: \`docs/governance/admin-role-and-removal.md\`." GOVERNANCE.md >/dev/null
grep -F "Admins share the same baseline authority in the bootstrap phase." GOVERNANCE.md >/dev/null
grep -F "Admin membership changes require public record and 2-admin approval." GOVERNANCE.md >/dev/null
grep -F "The admin under review does not count toward quorum or required approvals for their own restriction or removal." GOVERNANCE.md >/dev/null
grep -F "Bootstrap choice: Model B. Use a flat admin group with shared baseline authority, explicit multi-admin requirements for sensitive actions, and public recordkeeping for admin membership changes." "${POLICY_PATH}" >/dev/null
grep -F -- "- granting admin access" "${POLICY_PATH}" >/dev/null
grep -F -- "- restricting, suspending, or removing admin access through the normal process" "${POLICY_PATH}" >/dev/null
grep -F "Default response window for non-emergency removal or restriction decisions is 7 days." "${POLICY_PATH}" >/dev/null
grep -F "Emergency restriction does not by itself settle permanent removal." "${POLICY_PATH}" >/dev/null

echo "Admin role policy check passed."
