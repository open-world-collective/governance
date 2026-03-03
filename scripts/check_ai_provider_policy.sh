#!/usr/bin/env bash
set -euo pipefail

ROOT="${ROOT_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
cd "${ROOT}"

test -f AI_PROVIDER_POLICY.md
grep -F "See [AI_PROVIDER_POLICY.md](AI_PROVIDER_POLICY.md)." README.md >/dev/null
grep -F "mass domestic surveillance" AI_PROVIDER_POLICY.md >/dev/null
grep -F "fully autonomous weaponization" AI_PROVIDER_POLICY.md >/dev/null
grep -F "Approved: Anthropic" AI_PROVIDER_POLICY.md >/dev/null
grep -F "Not approved: OpenAI" AI_PROVIDER_POLICY.md >/dev/null

echo "AI provider policy check passed."
