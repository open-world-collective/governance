#!/usr/bin/env bash
set -euo pipefail

ROOT="${ROOT_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
cd "${ROOT}"

POLICY_PATH="docs/governance/continuity-and-succession.md"

test -f "${POLICY_PATH}"
grep -F "Canonical policy: \`docs/governance/continuity-and-succession.md\`." GOVERNANCE.md >/dev/null
grep -F "## Conflicts and recusals" GOVERNANCE.md >/dev/null
grep -F "Conflicted admins must disclose and recuse from the affected decision." GOVERNANCE.md >/dev/null
grep -F "Minimum operational target is 2 active admins." "${POLICY_PATH}" >/dev/null
grep -F "If active admin coverage drops below 2, only emergency continuity actions should proceed until coverage is restored." "${POLICY_PATH}" >/dev/null
grep -F "When possible, at least 2 admins should confirm the private runbook is current and usable at least quarterly and after any major service or personnel change." "${POLICY_PATH}" >/dev/null
grep -F -- "- At 30 days without response after at least 2 contact attempts across 2 different channels, open a continuity issue and record the contact attempts." "${POLICY_PATH}" >/dev/null
grep -F -- "- Verify the private continuity runbook exists and has been reviewed recently." "${POLICY_PATH}" >/dev/null

echo "Continuity policy check passed."
