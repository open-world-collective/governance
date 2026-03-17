#!/usr/bin/env bash
set -euo pipefail

ROOT="${ROOT_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"

PACKET="${ROOT}/docs/governance/ratification-approval-packet.md"
PROCESS="${ROOT}/docs/governance/policy-change-process.md"
README_FILE="${ROOT}/README.md"

test -f "${PACKET}"
test -f "${PROCESS}"
test -f "${README_FILE}"

grep -F 'Ratification approval packet (`docs/governance/ratification-approval-packet.md`)' "${README_FILE}" >/dev/null
grep -F 'For a reusable approval-comment format, see `docs/governance/ratification-approval-packet.md`.' "${PROCESS}" >/dev/null
grep -F 'post a clear approval packet and `@mention` the admins whose approval is needed' "${PROCESS}" >/dev/null
grep -F 'Include `@qarl` on ratification requests' "${PROCESS}" >/dev/null
grep -F 'pending admins with known GitHub usernames' "${PROCESS}" >/dev/null

grep -F '# Ratification Approval Packet' "${PACKET}" >/dev/null
grep -F '### 6. Delivery and notification' "${PACKET}" >/dev/null
grep -F '`@mention` the admins whose approval is needed' "${PACKET}" >/dev/null
grep -F 'include `@qarl` on ratification requests' "${PACKET}" >/dev/null
grep -F 'pending-admin comments do not count toward approval quorum until the invite is accepted' "${PACKET}" >/dev/null

echo "Ratification process docs check passed."
