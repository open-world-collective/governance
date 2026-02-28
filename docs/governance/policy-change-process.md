# Policy Change Process (Draft v1)

This document defines how governance/policy rules in this repository are proposed, discussed, approved, recorded, and adopted.

It exists to satisfy the manifesto commitment to transparent rule changes (“in writing”).

This is a governance policy draft and is not legal advice.

## Scope

Applies to governance and policy documents in this repo, including:

- `docs/**`
- Repo-root governance docs (`README.md`, `GOVERNANCE.md`, etc.)

## Definitions

- **Editorial change**: typos, formatting, or clarifications that do not change meaning or behavior.
- **Policy change**: any change that affects rights, obligations, decision rules, moderation, finances, transparency, or operational expectations.
- **Emergency change**: a time-sensitive policy change where delay creates material safety/security/financial risk.

## Default workflow (policy changes)

1. **Propose**: open an issue using the `Policy proposal` template (`.github/ISSUE_TEMPLATE/policy_proposal.yml`).
2. **Discuss**:
   - Minor/iterative changes: keep the issue open for comment for at least 72 hours.
   - Significant changes: use an RFC-style issue and allow at least 7 days for comment (see `CONTRIBUTING.md`).
3. **Decide**: admins vote per `docs/governance/roles-and-voting.md` (quorum of at least 2 active admins).
4. **Record**: log the accepted decision in `docs/decision-log.md` with:
   - date + decision ID
   - summary and decision text
   - approvers (and recusals, if any)
   - links to the issue + PR
   - follow-ups/owners
5. **Adopt**: merge the PR. Default effective date is the merge timestamp unless the decision specifies otherwise.
6. **Review**: for significant changes, include a revisit date or review trigger (e.g., “after 90 days” or “after first incident”).

## Editorial changes

- May be merged via PR with at least one admin approval.
- Do not require a decision log entry unless they also resolve an open governance decision.

## Emergency changes

- Require explicit 2-admin signoff in the issue or PR thread.
- Must be timeboxed when possible (e.g., “temporary until <date>”).
- Must have a retrospective decision log entry within 7 days describing why emergency handling was required.

## Transparency requirements

- Every policy PR links to the proposal issue.
- Every adopted policy change has a decision log entry linking back to both the issue and PR.
- When details cannot be public, publish a redacted summary with rationale (never “trust us”).
