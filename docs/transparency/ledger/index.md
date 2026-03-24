# Public Ledger Index

This directory is the bootstrap public ledger for Open World Collective.

Current provider status: no external ledger provider is active yet. Until one is adopted, the canonical public ledger lives in this repository under `docs/transparency/ledger/`.

## Current state

- No project funds are currently held in a separate treasury.
- No public-ledger transactions have been recorded yet.
- This ledger exists now so future spending can start from a stable public structure instead of improvising once money begins to move.

## File structure

- `index.md` — this index and provider status note
- `YYYY-MM.md` — human-readable monthly ledger view
- `YYYY-MM.csv` — machine-readable monthly ledger export for the same period

## Entry format

Each transaction should have a stable entry ID in the form:

- `L-YYYY-MM-001`

Each monthly Markdown file should include, for every entry:

- ledger entry ID
- date
- amount + currency
- payee/vendor label
- category
- purpose
- approval reference
- receipt or redacted receipt link
- variance/exceptions note
- status

The matching CSV should carry the same information in machine-readable columns.

## Corrections

- Do not silently rewrite transaction history after publication.
- If a record is wrong, add a correction or reversal entry and note what changed.
- If a file is corrected for formatting or redaction only, note that in the Markdown file.

## Provider transition

If Open World Collective later adopts an external provider such as Open Collective, record that change through the normal governance process.

At that point:

- the external provider becomes the canonical transaction host
- this directory remains the public index and monthly reporting link surface unless governance later chooses a different structure
