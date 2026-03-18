# Ratification Approval Packet

Use this template when asking admins to ratify a governance or policy change.

The goal is to make the approval ask explicit enough that no approver has to guess what the vote means.

This is a governance process note and is not legal advice.

## Required structure

### 1. What is being approved

One sentence naming the exact file or PR.

Example:

`Approve docs/transparency/public-ledger-policy.md as the project's public-ledger transparency policy, using the merged text from PR #13.`

### 2. What changes if approved

List 2 to 4 concrete changes.

Example:

- public ledger entries become the canonical public references for money movement
- each entry must include approval links, metadata, and receipt or redacted receipt references
- monthly reports must link transactions back to ledger entries and approval records

### 3. What does not change

List 1 to 3 scope boundaries.

Example:

- this does not approve any specific spending by itself
- this does not replace the 2-admin approval rule in `docs/governance/fund-approval.md`
- this does not require publishing private personal or account details

### 4. Why now

One sentence on the gap being closed.

Example:

`We already have reporting cadence and fund-approval rules; this closes the gap on what public ledger entries must contain and how reports should point back to them.`

### 5. Exact approval wording

Give admins a copy-paste line.

Example:

`Approved: ratify docs/transparency/public-ledger-policy.md as merged in PR #13.`

### 6. Delivery and notification

Post the packet in the public issue or PR thread that will hold the approval trail.

When asking for approval on GitHub:

- `@mention` the admins whose approval is needed so GitHub sends a notification
- include `@qarl` on ratification requests
- include any pending admins who already have GitHub usernames, for visibility
- pending-admin comments do not count toward approval quorum until the invite is accepted
- keep the approvals in one clear location instead of splitting them across multiple threads

### 7. Next-day follow-up

If the vote does not have enough responses by the next day:

- post a short follow-up comment in plainer English
- explain the issue in simple terms before re-asking for votes
- `@mention` the admins who have not responded yet
- repeat the exact approval wording so the reply can stay short

## Retro-ratification note

If the text is already merged, say that plainly:

`The text is already merged; this approval ratifies it into the formal governance record.`

## Practical rule

If an admin could reasonably ask “what am I approving?”, the packet is not ready yet.
