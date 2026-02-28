# Public Ledger Transparency Policy (Draft v1)

This policy defines how project financial activity is recorded in a public ledger and referenced from transparency reports.

This is a governance policy draft and is not legal advice.

## Scope

Applies to all project funds, including reimbursements and vendor payments.

This policy is complementary to (and does not replace) `docs/governance/fund-approval.md`.

## Goals

- Make financial activity legible to contributors and the public.
- Make approvals auditable (who approved what, and when).
- Avoid “trust us” governance by keeping a durable, linkable record.

## Canonical record

The project maintains a public ledger (for example, Open Collective). Ledger entries are treated as the canonical references for money movement, and they should be linkable from governance issues and transparency reports.

If the ledger provider changes, record the change via the standard policy change process and update references in this repo.

## Required metadata for ledger entries

Each ledger entry should include (directly in the entry or via a stable link):

- Date (or posting date)
- Amount + currency
- Payee/vendor name (or a redacted label if publishing the name would cause harm)
- Category (e.g., infra, moderation tooling, legal/admin, events)
- Purpose and expected outcome (one short paragraph)
- Approval reference:
  - a public issue link where the spend was proposed, and
  - explicit 2-admin signoff as required by `docs/governance/fund-approval.md`
- Receipt/invoice link (or a redacted receipt when needed)
- Notes on any variance from the approved amount or scope

## Linking policy

### From approvals to ledger

- Fund-approval issues should link to the final ledger entry once executed.
- Ledger entries should link back to the approving issue (and, if applicable, the decision log entry).

### From reports to ledger

Monthly transparency reports must include:

- a link to the public ledger (provider home and/or relevant report period view), and
- a list of all transactions for the period, each with a link to its ledger entry and approval reference.

## Redaction and disclosure boundaries

Default posture is transparency, with safety and privacy constraints:

- Do not publish credentials, account numbers, mailing addresses, phone numbers, or other sensitive personal data.
- For reimbursements to individuals, publish the minimum information needed for accountability (amount, category, purpose, approval links). Redact personal details as needed.
- If a receipt contains sensitive data, publish a redacted version and note that redaction occurred.
- If full details cannot be public, publish a redacted summary with rationale and keep the approval trail intact.

## Monthly reconciliation checklist

For each reporting period:

- Confirm every ledger transaction in the period appears in the monthly report with a link.
- Confirm each transaction has an approval reference and 2-admin signoff (or is explicitly marked as an emergency exception with retrospective).
- Confirm receipts/invoices are attached where appropriate (redacted if needed).
- Note any variances (amount or scope) and any follow-up obligations.
- List any missing data as a tracked follow-up item with an owner and due date.
