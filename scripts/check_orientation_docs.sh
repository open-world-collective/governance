#!/usr/bin/env bash
set -euo pipefail

ROOT="${ROOT_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
cd "${ROOT}"

ORIENTATION="docs/getting-oriented.md"
GLOSSARY="docs/glossary.md"

test -f "${ORIENTATION}"
test -f "${GLOSSARY}"
grep -F "Orientation guide (\`docs/getting-oriented.md\`)" README.md >/dev/null
grep -F "Glossary (\`docs/glossary.md\`)" README.md >/dev/null
grep -F "Need the short version first? Start with \`docs/getting-oriented.md\` and \`docs/glossary.md\`." GOVERNANCE.md >/dev/null
grep -F "If text is merged but not ratified yet, treat it as merged draft text, not as a fully recorded governance decision." "${ORIENTATION}" >/dev/null
grep -F "Current bootstrap quorum is 2 active admins." "${GLOSSARY}" >/dev/null
grep -F "During the bootstrap phase, this can live in the repo under \`docs/transparency/ledger/\` until an external provider is adopted." "${GLOSSARY}" >/dev/null

echo "Orientation docs check passed."
