# Conflict of Interest and Recusal (Draft v1)

This policy defines the baseline conflict-of-interest standard for governance, financial approvals, and appeals in this repository.

This is a governance policy draft and is not legal advice.

## Scope

Applies to admins and any other person acting as a reviewer, approver, or decision-maker in Open World Collective governance processes.

## Goals

- Reduce governance capture risk.
- Make decisions easier to trust and audit.
- Set a practical bootstrap baseline without requiring over-disclosure of private details.

## Baseline standard

A conflict exists when a reasonable person would question whether someone can act impartially on a specific decision.

Conflicts include, at minimum:

- direct financial interest in the outcome
- being the requestor, payee, or likely beneficiary of a financial decision
- close personal, romantic, familial, or household relationship with an affected party
- employment, contractor, vendor, or customer relationship with an affected party
- direct prior involvement in the incident or decision under review
- any other circumstance likely to compromise independent judgment

## Options considered

- Financial-only conflicts: too narrow for moderation, hiring, vendor, and governance decisions.
- Disclosure without recusal: too easy to abuse in a small bootstrap group.
- Blanket exclusion from all related discussion: too rigid for small-team operations.

Bootstrap choice: disclose conflicts early, allow factual background when needed, but require recusal from approval and final decision-making.

## Disclosure rules

- Disclose known conflicts before substantive discussion, recommendation, approval, or vote.
- If a conflict is discovered later, disclose it promptly in the same issue, PR, or decision thread.
- Public records should disclose the existence and general type of conflict. Do not publish unnecessary private details.

Examples of acceptable public disclosure:

- `financial conflict; recused`
- `prior involvement in incident; recused from appeal review`
- `close relationship with affected party; recused`

## Recusal rules

When conflicted, the person must:

- not cast a deciding vote
- not count toward required approval minimums or quorum for that decision
- not act as the sole reviewer or approver

They may still:

- provide factual background if requested by the uninvolved reviewers
- answer clarifying questions about timeline or context

They may not:

- write the final approval determination
- review an appeal of their own moderation action
- self-approve reimbursements, payments, contracts, or other benefits to themselves

## Substitute approver rules

- Use another uninvolved admin whenever possible.
- For financial approvals, the requestor and payee cannot serve as required approvers.
- For moderation appeals, reviewers must be admins not directly involved in the original action.
- If recusals make quorum impossible, defer the decision until enough uninvolved reviewers are available.
- If delay creates material safety, security, or financial risk, temporary emergency action may proceed under the relevant policy, followed by retrospective review and recordkeeping.

## Recordkeeping

- Issues and PRs should note disclosed conflicts and recusals in the discussion thread.
- Accepted decisions logged in `docs/decision-log.md` should list approvers and any recusals.
- Financial approvals should link the disclosed conflict/recusal note when relevant.

## If a conflict is discovered after a decision

- Record the late-discovered conflict in the relevant issue or PR.
- Re-evaluate whether the decision should be confirmed, amended, or reopened by uninvolved reviewers.
- Note the outcome in the decision log if the original decision was already recorded there.
