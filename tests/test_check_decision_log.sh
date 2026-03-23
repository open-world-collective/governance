#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHECK_SCRIPT="${REPO_ROOT}/scripts/check_decision_log.sh"

assert_fails() {
  if "$@"; then
    echo "expected failure but command succeeded: $*" >&2
    exit 1
  fi
}

mk_case_dir() {
  mktemp -d "${TMPDIR:-/tmp}/gov-decision-log-test.XXXXXX"
}

write_valid_case() {
  local dir="$1"
  mkdir -p "${dir}/docs"
  cat >"${dir}/docs/decision-log.md" <<'EOF'
# Decision Log

Use this log for governance or financial-control decisions.

## Entries

- 2026-02-28 | GOV-001 | Created governance repository and bootstrap docs. | Bootstrap phase for early public collaboration readiness. | Govern via admin majority with documented decisions. | open-world-collective admins | Seed governance roadmap issues.
- 2026-03-16 | GOV-002 | Ratified bootstrap governance repo scope. | Needed a public statement of what belongs in this repo versus technical repos after docs/scope.md landed in PR #12. | Adopt docs/scope.md as the bootstrap scope definition for the governance repo. | qarl, Sniffleupagus (via issue #1 approvals) | Keep scope links aligned across README, governance docs, and future technical-repo policy references; links: issue #1, PR #12; recusals: none.
- 2026-03-16 | GOV-003 | Ratified public-ledger transparency policy. | Needed explicit public-ledger rules for metadata, approval links, redaction boundaries, and monthly reconciliation after docs/transparency/public-ledger-policy.md landed in PR #13. | Adopt docs/transparency/public-ledger-policy.md as the bootstrap public-ledger transparency policy. | qarl, makingentropy (via issue #5 approvals) | Use the updated ledger/reporting docs for the March 2026 transparency report and keep ledger links aligned with approval records; links: issue #5, PR #13; recusals: none.
- 2026-03-18 | GOV-004 | Ratified fund-approval policy. | Needed a formal record for the existing fund-approval rule on main so spend controls are explicit and auditable rather than implied by repo history. | Adopt docs/governance/fund-approval.md as the bootstrap fund-approval policy. | qarl, Sniffleupagus (via issue #4 approvals) | Use the policy as the required pre-approval baseline for project spending and reimbursements; links: issue #4, commit 127f2c0; recusals: none.
- 2026-03-20 | GOV-005 | Ratified moderation and appeals policy. | Needed an explicit due-process and appeals procedure for official project spaces after docs/policies/moderation-and-appeals.md landed in PR #14. | Adopt docs/policies/moderation-and-appeals.md as the bootstrap moderation and appeals policy. | qarl, sealfoss (via issue #7 approvals) | Use the policy for official project spaces and record future structural revisions through the policy-change process; links: issue #7, PR #14; recusals: none.
- 2026-03-20 | GOV-006 | Ratified conflict-of-interest policy. | Existing governance docs referenced recusals, but the repo lacked a canonical baseline defining conflicts, disclosure timing, substitute approvers, and late-discovered conflicts before PR #16 landed. | Adopt docs/governance/conflict-of-interest.md as the bootstrap conflict-of-interest and recusal policy. | sealfoss, makingentropy (via PR #16 approvals) | Use the policy as the baseline for governance and fund-approval decisions, and record future structural revisions through the policy-change process; links: issue #8, PR #16; recusals: none.
- 2026-03-21 | GOV-007 | Ratified continuity and succession policy. | Needed a public continuity baseline for admin coverage, inactivity handling, and private runbook expectations after docs/governance/continuity-and-succession.md landed in PR #17, so an actual continuity incident would not force ad hoc decisions. | Adopt docs/governance/continuity-and-succession.md as the bootstrap continuity and succession policy. | sealfoss, qarl (via PR #17 approvals) | Review continuity coverage, admin count, and private-runbook usability by 2026-06-30; runbook confirmations: qarl, makingentropy via issue #9; links: issue #9, PR #17; recusals: none.
- 2026-03-22 | GOV-008 | Ratified bootstrap voting rule. | The repo was already operating with docs/governance/roles-and-voting.md on main, but the baseline quorum, majority, tie-handling, and vote-window rules had not been ratified into the decision log. | Adopt docs/governance/roles-and-voting.md as the bootstrap admin voting rule. | qarl, sealfoss (via issue #3 approvals) | Use the rule as the default governance decision path until a later ratified voting model replaces it; links: issue #3, docs/governance/roles-and-voting.md; recusals: none.
- 2026-03-22 | GOV-009 | Ratified transparency reporting cadence. | The repo already had monthly reporting docs, but the cadence needed a formal record after ownership and publication defaults were clarified in commit 9409b73. | Adopt docs/transparency/reporting-cadence.md as the bootstrap monthly transparency reporting cadence and publication rule. | qarl, sealfoss (via issue #6 approvals) | Use the cadence for the March 2026 report and future monthly reporting cycles; links: issue #6, issue #15, commit 9409b73; recusals: none.
- 2026-03-23 | GOV-010 | Ratified admin role and removal policy. | The repo had voting, continuity, conflict, and fund-approval rules, but it did not yet have a canonical policy for baseline admin authority, membership changes, or removal process before docs/governance/admin-role-and-removal.md landed on main. | Adopt docs/governance/admin-role-and-removal.md as the bootstrap admin role, authority-limit, onboarding, restriction, and removal policy. | makingentropy, qarl (via issue #2 approvals) | Use the policy as the baseline for future admin onboarding, restriction, and replacement actions; links: issue #2, commit 162266a; recusals: none.
EOF
}

main() {
  local d1 d2 d3

  d1="$(mk_case_dir)"
  write_valid_case "${d1}"
  ROOT_DIR="${d1}" bash "${CHECK_SCRIPT}"

  d2="$(mk_case_dir)"
  mkdir -p "${d2}/docs"
  cat >"${d2}/docs/decision-log.md" <<'EOF'
# Decision Log

## Entries

- 2026-03-16 | GOV-001 | Missing fields entry.
EOF
  assert_fails env ROOT_DIR="${d2}" bash "${CHECK_SCRIPT}"

  d3="$(mk_case_dir)"
  mkdir -p "${d3}/docs"
  cat >"${d3}/docs/decision-log.md" <<'EOF'
# Decision Log

## Entries

- 2026-02-28 | GOV-001 | First entry. | Context. | Decision. | Admins. | Follow-up.
- 2026-03-16 | GOV-001 | Duplicate id. | Context. | Decision. | Admins. | Follow-up.
EOF
  assert_fails env ROOT_DIR="${d3}" bash "${CHECK_SCRIPT}"

  ROOT_DIR="${REPO_ROOT}" bash "${CHECK_SCRIPT}"
  grep -F "GOV-002" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "issue #1, PR #12" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "GOV-003" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "issue #5, PR #13" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "GOV-004" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "issue #4, commit 127f2c0" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "GOV-005" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "issue #7, PR #14" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "GOV-006" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "issue #8, PR #16" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "GOV-007" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "issue #9, PR #17" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "GOV-008" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "issue #3, \`docs/governance/roles-and-voting.md\`" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "GOV-009" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "issue #6, issue #15, commit \`9409b73\`" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "GOV-010" "${REPO_ROOT}/docs/decision-log.md" >/dev/null
  grep -F "issue #2, commit \`162266a\`" "${REPO_ROOT}/docs/decision-log.md" >/dev/null

  rm -rf "${d1}" "${d2}" "${d3}"
  echo "check_decision_log tests passed."
}

main "$@"
