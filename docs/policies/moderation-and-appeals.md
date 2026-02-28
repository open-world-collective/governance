# Moderation and Appeals (Draft v1)

This policy defines baseline moderation actions and a meaningful appeals process for Open World Collective-operated project spaces. It implements the manifesto commitments to due process before exile and meaningful appeals (`docs/manifesto.md`).

This is a governance policy draft and is not legal advice.

## Goals

- Keep participation safe and constructive.
- Make moderation actions understandable, reviewable, and appealable.
- Preserve due process (especially for “exile” / permanent removal).
- Support transparency without forcing unsafe disclosure.

## Scope

Applies to official project spaces operated by Open World Collective (e.g., official servers, community channels, and org-managed infrastructure).

This policy does not define every content rule; it defines the process for enforcing rules and reviewing enforcement.

## Definitions

- **Significant action**: any moderation action that materially restricts participation (timeouts, mutes, bans, role/access removal), or any action likely to affect reputation or livelihood.
- **Exile**: a permanent ban/removal from official project spaces or revocation of participation rights.
- **Emergency action**: immediate temporary restriction taken to prevent imminent harm (safety, security, or severe disruption).

## Moderation actions (taxonomy)

Moderators/admins may use the least-restrictive action that addresses the situation:

- **Informal nudge**: a brief correction or reminder (no record required unless escalated).
- **Warning**: a written notice that future violations may result in restrictions.
- **Content/action removal**: delete/rollback content or actions (messages, posts, builds) when necessary.
- **Temporary restriction**: timeout/mute/limited access for a defined duration.
- **Temporary ban**: removal for a defined duration (hours to weeks).
- **Permanent ban (exile)**: indefinite removal from official project spaces.

Emergency actions are allowed, but must be documented and reviewed promptly.

## Framework options considered

This draft uses a “progressive enforcement” approach (least-restrictive action first, escalating only when needed). Alternatives considered include:

- **Strike systems** (simple rules, but often fail on context-heavy incidents).
- **Zero-tolerance lists** (clear, but can be overbroad and invite rigid misapplication).
- **Community juries** (more legitimacy, but heavy process cost in early bootstrap phase).

## Notice requirements

For significant actions, provide notice to the affected person (when safe to do so) including:

- what behavior triggered the action (short description)
- policy basis (what rule or principle was violated)
- action taken + duration (if temporary)
- how to appeal and where
- what evidence exists (summary + references, with redaction as needed)

For emergency actions, notice may follow after immediate safety needs are addressed.

## Moderation action record (required for significant actions)

Every significant action must have a durable record. Default posture is a public record with redaction as needed.

### Minimum fields

- Date/time (UTC recommended)
- Acting moderator/admin(s)
- Affected person (handle/ID)
- Location (server/channel)
- Action type (from taxonomy)
- Duration (or “permanent”)
- Policy basis (rule/principle)
- Evidence summary (and references/links if safe)
- Rationale (why this action, why this duration)
- Redactions made (what and why)
- Appeal status (none/pending/decided) and outcome link

### Where the record lives

- Default: a public GitHub issue with a redacted summary and the minimum fields above.
- If a public issue would create safety/privacy risk, keep sensitive details out of the public record and publish a redacted summary with rationale.
- Do not commit private transcripts, credentials, or sensitive personal data to this repo.

## Appeals process

### Who can appeal

- The affected person may appeal any significant moderation action.

### Appeal window

- Default: within 14 days of the action.
- Late appeals may be considered when the affected person could not reasonably appeal earlier.

### Appeal venue

- Default: a public GitHub issue (with redaction if needed).
- If safety/privacy requires, appeal may be initiated via a restricted channel (e.g., email to the admins), followed by a public redacted summary.

### Reviewers

- At least 2 admins not directly involved in the original action.
- If there are not 2 uninvolved admins available, the appeal must be paused until independent reviewers can be found (or the project must document an alternative review path).

### Response targets

- Acknowledge receipt: within 48 hours.
- Initial decision target: within 7 days.
- If more time is needed (e.g., collecting facts), post an update with a new target date.

### Standard of review

Reviewers should evaluate:

- whether the policy basis was valid and applied consistently
- whether evidence was sufficient
- whether the action was proportional (least-restrictive that would work)
- whether process requirements (notice + recordkeeping) were followed

### Possible outcomes

- uphold action
- modify action (duration/type)
- reverse action
- request additional facts before final outcome

### Recording the outcome

- Record the outcome in the appeal thread.
- If details cannot be public, publish a redacted summary with rationale.

## Scenario example

### Example: emergency temporary restriction, then appeal

- Incident: a participant repeatedly posts targeted harassment in an official channel.
- Immediate action: emergency 24-hour timeout to stop ongoing harm.
- Record: a moderation issue is opened with a redacted summary, links to the relevant policy basis, action type, duration, and rationale.
- Notice: the participant receives a message describing the action, the rule basis, and how to appeal.
- Appeal: the participant opens an appeal within 14 days, arguing context and disputing the interpretation.
- Review: two uninvolved admins review the evidence and process.
- Outcome: the timeout is upheld (or modified), and a public rationale is recorded (with redaction as needed).

## Transparency note

When details cannot be public, publish a redacted summary with rationale. “Trust us” is not sufficient.
