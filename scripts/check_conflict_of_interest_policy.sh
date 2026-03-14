#!/usr/bin/env bash
set -euo pipefail

ROOT="${ROOT_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
cd "${ROOT}"

POLICY_PATH="docs/governance/conflict-of-interest.md"

test -f "${POLICY_PATH}"
grep -F "Canonical policy: \`docs/governance/conflict-of-interest.md\`." GOVERNANCE.md >/dev/null
grep -F "Canonical policy: \`docs/governance/conflict-of-interest.md\`." docs/governance/roles-and-voting.md >/dev/null
grep -F "Conflicts and recusals follow \`docs/governance/conflict-of-interest.md\`." docs/governance/fund-approval.md >/dev/null
grep -F "A conflict exists when a reasonable person would question whether someone can act impartially on a specific decision." "${POLICY_PATH}" >/dev/null
grep -F -- "- Disclose known conflicts before substantive discussion, recommendation, approval, or vote." "${POLICY_PATH}" >/dev/null
grep -F -- "- Use another uninvolved admin whenever possible." "${POLICY_PATH}" >/dev/null

echo "Conflict-of-interest policy check passed."
