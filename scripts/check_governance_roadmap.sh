#!/usr/bin/env bash
set -euo pipefail

ROOT="${ROOT_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
cd "${ROOT}"

ROADMAP_PATH="docs/governance-roadmap.md"

test -f "${ROADMAP_PATH}"
grep -F "[Governance roadmap](docs/governance-roadmap.md) and [supporting roadmap notes](docs/roadmap/)" README.md >/dev/null
grep -F "Canonical roadmap: \`docs/governance-roadmap.md\`" docs/roadmap/milestones.md >/dev/null
grep -F "Canonical roadmap: \`docs/governance-roadmap.md\`" docs/roadmap/phases.md >/dev/null
grep -F "During the bootstrap phase, review this roadmap monthly." "${ROADMAP_PATH}" >/dev/null
grep -F "| M1 Baseline complete |" "${ROADMAP_PATH}" >/dev/null
grep -F "| M2 Operations routine |" "${ROADMAP_PATH}" >/dev/null
grep -F "| M3 Participation expansion |" "${ROADMAP_PATH}" >/dev/null
grep -F "1. ratify \`docs/governance/admin-role-and-removal.md\` through issue \`#2\`" "${ROADMAP_PATH}" >/dev/null

echo "Governance roadmap check passed."
