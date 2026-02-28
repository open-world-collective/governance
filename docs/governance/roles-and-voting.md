# Roles and Voting (v1)

## Roles

- Admins: accountable for governance decisions, release of policy updates, and financial approvals.
- Maintainers: trusted contributors who draft policy text and coordinate implementation details.
- Contributors: any community member proposing ideas, comments, or edits.

## Decision classes

- Standard policy decisions: simple majority of active admins.
- Financial decisions: governed by `docs/governance/fund-approval.md`.
- Emergency decisions: temporary admin action allowed when delay creates material risk.

## Voting rules

- Quorum: at least 2 active admins participate.
- Window: default vote window is 72 hours.
- Approval: more yes votes than no votes among participating admins.
- Tie: decision remains open until another admin vote is recorded.

## Conflict of interest

- Any admin with direct personal or financial conflict must disclose and recuse from that vote.
- Recusal is recorded in the decision log entry.

## Recordkeeping

- All accepted decisions are logged in `docs/decision-log.md`.
- Entries include approvers, recusals, and follow-up actions.
- Policy updates follow `docs/governance/policy-change-process.md`.
