#!/usr/bin/env bash
set -euo pipefail

ROOT="${ROOT_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
LOG_FILE="${ROOT}/docs/decision-log.md"

test -f "${LOG_FILE}"
grep -F "# Decision Log" "${LOG_FILE}" >/dev/null
grep -F "## Entries" "${LOG_FILE}" >/dev/null

awk '
BEGIN {
  in_entries = 0
  count = 0
}
/^## Entries$/ {
  in_entries = 1
  next
}
in_entries && /^- / {
  count++
  line = $0
  temp = line
  separator_count = gsub(/ \| /, "&", temp)
  if (separator_count != 6) {
    print "invalid decision-log field count on line " NR > "/dev/stderr"
    exit 1
  }
  split(line, parts, " \\| ")
  if (parts[1] !~ /^- [0-9]{4}-[0-9]{2}-[0-9]{2}$/) {
    print "invalid decision-log date on line " NR > "/dev/stderr"
    exit 1
  }
  if (parts[2] !~ /^GOV-[0-9]{3}$/) {
    print "invalid decision ID on line " NR > "/dev/stderr"
    exit 1
  }
  if (seen[parts[2]]++) {
    print "duplicate decision ID " parts[2] > "/dev/stderr"
    exit 1
  }
}
END {
  if (!in_entries) {
    print "missing decision-log entries section" > "/dev/stderr"
    exit 1
  }
  if (count == 0) {
    print "decision log has no entries" > "/dev/stderr"
    exit 1
  }
}
' "${LOG_FILE}"

echo "Decision log check passed."
