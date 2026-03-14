# Continuity and Succession (Draft v1)

This policy defines the baseline continuity and succession standard for governance operations in this repository.

This is a governance policy draft and is not legal advice.

## Scope

Applies to admin continuity, governance account recovery planning, and succession/replacement when an admin becomes unavailable.

## Goals

- Remove single-point admin failure.
- Keep governance operations recoverable.
- Provide a practical bootstrap process without publishing sensitive recovery details in a public repo.

## Options considered

- Single-admin fallback: too fragile for governance, finance, and appeals.
- Public recovery runbook: too risky because it invites disclosure of sensitive account details.
- Immediate automatic removal for inactivity: too rigid for a small bootstrap team.

Bootstrap choice: require at least 2 active admins, maintain a private recovery runbook with a public checklist, and use threshold-based review before replacement.

## Baseline continuity standard

- Minimum operational target is 2 active admins.
- Preferred target is 3 active admins to reduce deadlock and continuity risk.
- If active admin coverage drops below 2, only emergency continuity actions should proceed until coverage is restored.

## Active admin definition

An active admin is an admin who:

- still holds the relevant org/repo role
- can be reached through the recorded governance contact channels
- can acknowledge governance matters within 7 days during normal operations

A short acknowledgment counts. Constant availability is not required.

## Critical access coverage

No critical governance dependency should rely on only one person without a recovery path.

At minimum, the project should maintain coverage or recovery planning for:

- GitHub org/repo admin access
- primary domain/DNS control
- primary project email or mailing-list account
- public-ledger / financial administration access
- any secret-storage or deployment system required to keep official operations running

## Private continuity runbook

The detailed runbook should live outside the public repository.

It should include:

- the list of critical accounts/services
- current human owners or custodians
- where recovery methods live
- contact order for continuity incidents
- last review date

Do not commit credentials, recovery codes, or private contact details to this repo.

When possible, at least 2 admins should confirm the private runbook is current and usable at least quarterly and after any major service or personnel change.

## Inactivity review thresholds

- At 14 days without acknowledgment to a governance contact, send a follow-up through a second channel if available.
- At 30 days without response after at least 2 contact attempts across 2 different channels, open a continuity issue and record the contact attempts.
- At 45 days without response, or sooner if active admin coverage drops below 2, begin replacement or recovery action.

## Replacement and recovery triggers

Begin continuity action when any of the following is true:

- active admin coverage drops below 2
- an admin is unavailable past the threshold above
- loss of account access creates a material governance, security, or financial risk

## Replacement and recovery process

- Open a continuity issue documenting the operational risk and the attempted contact dates.
- Keep private details out of the issue; use redacted summaries where needed.
- Remaining active admins should take the minimum actions needed to restore access coverage or admin count.
- If normal quorum is unavailable, use the narrowest emergency continuity action needed to restore the minimum operational target.
- After continuity is restored, record the outcome in `docs/decision-log.md`.

## Actionable checklist

- Verify the project still has at least 2 active admins.
- Verify the private continuity runbook exists and has been reviewed recently.
- Verify critical services have either shared admin coverage or a documented recovery path.
- Verify contact channels for each admin are still current.
- If any item fails, open or update a continuity issue and assign a follow-up owner.
