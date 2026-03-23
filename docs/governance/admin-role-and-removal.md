# Admin Roles, Limits, and Removal (Draft v1)

This policy defines the bootstrap admin role model, authority limits, and admin onboarding/removal process for Open World Collective governance.

This is a governance policy draft and is not legal advice.

## Scope

Applies to:

- who holds admin status for governance purposes
- what admins are expected and allowed to do
- how admin membership is added, replaced, restricted, or removed

## Goals

- Keep admin authority clear, limited, and auditable.
- Avoid single-person control over governance, finance, and role changes.
- Provide a practical bootstrap model that works with a small admin group.

## Candidate models considered

### Model A: single lead admin with helpers

- Pros: simple and fast.
- Cons: too much concentrated control, weak succession path, weak appeal legitimacy.

### Model B: flat admin group with shared baseline authority

- Pros: simple to understand, resilient for a small team, works with existing voting and continuity policies.
- Cons: can deadlock more easily and needs clear rules for role changes and recusals.

### Model C: tiered chair / board / operator structure

- Pros: more separation of duties.
- Cons: too heavy for the current project size and would add titles without enough people to justify them.

Bootstrap choice: Model B. Use a flat admin group with shared baseline authority, explicit multi-admin requirements for sensitive actions, and public recordkeeping for admin membership changes.

## Admin responsibilities

Admins are responsible for:

- ratifying governance policies and structural changes
- approving fund decisions as required by `docs/governance/fund-approval.md`
- serving as appeal reviewers when not directly involved or conflicted
- maintaining continuity coverage and reviewing private runbook status
- approving admin onboarding, replacement, restriction, or removal actions

Admins may delegate drafting work, but not their approval responsibility.

## Admin limits

No single admin may:

- unilaterally change governance policy outside the emergency path
- self-approve payments, reimbursements, contracts, or personal benefits
- approve or vote on their own onboarding, restriction, or removal
- count toward quorum for a decision where they are conflicted or under review

Conflicts and recusals follow `docs/governance/conflict-of-interest.md`.

## Multi-admin requirements

The following actions require at least 2 active, non-conflicted admin approvals documented in a public issue, PR, or decision thread:

- governance policy adoption or structural change
- fund approvals covered by `docs/governance/fund-approval.md`
- granting admin access
- restricting, suspending, or removing admin access through the normal process
- appointing a replacement admin after resignation, removal, or continuity loss

If the admin under review is the subject of the decision, they do not count toward quorum or approval minimums for that action.

## Admin onboarding and replacement flow

When adding or replacing an admin:

1. Open a public issue naming the candidate and the reason for appointment or replacement.
2. State the expected responsibilities and any critical access they will need.
3. Disclose any known conflicts relevant to the appointment.
4. Record at least 2 active admin approvals.
5. Grant the minimum required access.
6. Update continuity records and any private runbook references promptly after access is granted.

## Removal and restriction triggers

Admin restriction, replacement, or removal may be considered when any of the following is true:

- the admin resigns
- the admin becomes unavailable under the thresholds in `docs/governance/continuity-and-succession.md`
- the admin loses the required org/repo access or cannot perform core admin responsibilities
- the admin repeatedly ignores conflict, approval, transparency, or continuity obligations
- the admin abuses privileges, acts in bad faith, or creates material governance, safety, or financial risk

Not every trigger requires permanent removal. Some cases only need temporary restriction, recovery action, or replacement planning.

## Normal removal or restriction process

- Open a public issue describing the concern in plain language.
- Record the factual basis and requested action: warning, temporary restriction, removal, or replacement.
- Give the admin under review a reasonable chance to respond unless an emergency exception applies.
- Keep unnecessary private details out of the public thread; use a redacted summary when needed.
- Require at least 2 active, non-conflicted admin approvals for the final action.
- Record the outcome in `docs/decision-log.md` if the action is accepted.

Default response window for non-emergency removal or restriction decisions is 7 days.

## Emergency restriction path

If an admin account appears compromised, abusive, or poses an immediate material risk, remaining admins may take the narrowest temporary action needed to contain the risk before the normal response window ends.

Examples:

- temporarily removing org/repo admin access from a compromised account
- freezing a sensitive action until uninvolved admins review it

Emergency restriction does not by itself settle permanent removal. Remaining admins should open or update the public issue, document the reason for the emergency step, and complete retrospective review as soon as practical.

## Recordkeeping

- Public threads for admin onboarding, replacement, restriction, or removal should identify the proposed action and the final outcome.
- Accepted structural changes should be recorded in `docs/decision-log.md`.
- Continuity-related admin changes should also update the private continuity runbook and any public continuity checklist references.

