# Merge AI Groups Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Merge AI1 and AI2 into one `✨ AI` policy without interrupting OpenClash DNS.

**Architecture:** First publish `✨ AI` with a temporary `✨ AI1` compatibility alias. After OpenClash loads it, switch DNS and AI-specific custom rules to the new group, then publish the final templates without the alias.

**Tech Stack:** Subconverter INI, Surge-style rule lists, PowerShell validation, OpenClash/Mihomo.

**Spec:** `docs/superpowers/specs/2026-10-23-merge-ai-groups-design.md`

## Global Constraints

- The final policy name is exactly `✨ AI`.
- The default is `美国-自动`; `DIRECT` is forbidden in the AI selector.
- Preserve unrelated OpenClash override rules and DNS behavior.
- Do not remove compatibility until DNS and custom AI references have moved.

## Review Focus

- A stale `AI1` DNS tag must not survive final cleanup.
- `AI2.list` rules must remain in `AI.list`.
- The two templates must use the same emoji and group name.
- The temporary alias must not survive the final template.
- AI-specific custom rules must not become direct during migration.

---

### Task 1: Publish compatible merged group

**Files:** Modify `AI.list`, both INIs, `README.md`; test `tests/validate-ai-merge.ps1`.

- [ ] Write and run the validator; expect failure because `✨ AI` does not exist.
- [ ] Merge the three AI2 rules and four AI override rules into `AI.list`.
- [ ] Point both templates at `✨ AI`, remove AI2, and add temporary `✨ AI1 -> ✨ AI`.
- [ ] Run `tests/validate-ai-merge.ps1 -AllowLegacyAlias`; expect success.
- [ ] Commit and push.

### Task 2: Switch OpenClash live references

**Files:** OpenClash DNS and custom-rule override settings.

- [ ] Update subscription and confirm `✨ AI` plus compatibility alias are loaded.
- [ ] Change four DNS tags from `#✨ AI1` to `#✨ AI`.
- [ ] Remove the five AI-specific custom rules now covered by `AI.list`.
- [ ] Save/apply and verify DNS plus OpenAI/Claude rule hits.

### Task 3: Remove compatibility artifacts

**Files:** Modify both INIs and `README.md`; delete `AI2.list`.

- [ ] Remove the temporary `✨ AI1` alias and delete `AI2.list`.
- [ ] Run `tests/validate-ai-merge.ps1`; expect success.
- [ ] Commit, push, update subscription, and verify no AI1/AI2 remains at runtime.

