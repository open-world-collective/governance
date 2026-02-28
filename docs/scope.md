# Repo Scope (Bootstrap)

This document defines what this governance repository owns, and what should live in technical repos.

This is governance process documentation and is not legal advice.

## Why this exists

Open World Collective is building “shared space” with “shared power.” That requires written rules, and it also requires clarity about where those rules live so contributors can find and change them transparently.

## In scope (this repo)

This repo is the canonical home for:

- Project intent documents: manifesto and charter.
- Governance process: roles, voting, policy change workflow, and decision logging.
- Financial controls and transparency rules: fund approval requirements, public-ledger expectations, reporting cadence and templates.
- Rights and due process policies: moderation and appeals process (and related rights baselines).
- Governance ADRs: decisions about governance structure, policy architecture, and document structure.

## Out of scope (this repo)

This repo is not the canonical home for:

- Technical implementation details (code, configs, deployment steps, architecture decisions).
- Product/engine/runtime design decisions that should be tracked alongside the code that implements them.
- Private operational artifacts (credentials, private chat logs, or anything under `.Jimmy/`).

This repo may still define governance-level requirements that technical repos must satisfy (e.g., “there must be an appeals process”), but the implementation detail belongs with the implementation.

## Cross-repo ownership table

When in doubt: policy here, implementation there.

| Topic | Canonical repo | Canonical artifacts | Notes |
| --- | --- | --- | --- |
| Manifesto / charter | `governance` | `docs/manifesto.md`, `docs/charter.md` | Why we exist; constraints we promise. |
| Voting / decision process | `governance` | `docs/governance/roles-and-voting.md`, `docs/decision-log.md` | How decisions are made and recorded. |
| Financial approvals | `governance` | `docs/governance/fund-approval.md` | Execution occurs elsewhere; approvals and audit trail are public. |
| Transparency reports | `governance` | `docs/transparency/*` | Monthly reports point to public ledger and decisions. |
| Moderation and appeals | `governance` | `docs/policies/moderation-and-appeals.md` | Due process and appeal rules; implementation varies by platform. |
| Minecraft server runtime | `paper-runtime` | (project repo) | Runtime configs, deployment, plugin lists, operations runbooks. |
| Client tooling / terminals | `enderterm` | (project repo) | Product design and implementation lives with the code. |

## How to route proposals

- Governance/policy changes: open a `Policy proposal` issue in this repo and follow `docs/governance/policy-change-process.md`.
- Technical/implementation changes: open an issue/PR in the technical repo, linking back to any relevant governance policy.
- Cross-cutting changes: open issues in both places and cross-link; the governance repo should state the requirement, and the technical repo should track the implementation.

## Changing this scope

This is a bootstrap scope and can evolve. Propose scope changes via the standard policy change process and record adoption in the decision log when approved.
