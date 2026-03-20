#!/usr/bin/env bash
set -euo pipefail

ROOT="${ROOT_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
GITIGNORE_FILE="${ROOT}/.gitignore"
README_FILE="${ROOT}/README.md"
PURPOSE_FILE="${ROOT}/docs/project-purpose.md"

test -f "${GITIGNORE_FILE}"
test -f "${README_FILE}"
test -f "${PURPOSE_FILE}"

grep -F 'private/' "${GITIGNORE_FILE}" >/dev/null
grep -F 'Short project description (`docs/project-purpose.md`)' "${README_FILE}" >/dev/null
grep -F '# What We Are Trying to Do' "${PURPOSE_FILE}" >/dev/null

echo "Repo local basics check passed."
