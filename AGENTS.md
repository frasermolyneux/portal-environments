# AGENTS.md — portal-environments

Terraform-only repository that provisions **portal environment infrastructure** on Azure: App Configuration (with Key Vault-backed secrets), API Management (consumption tier), Azure AD app registrations / service principals (Repository APIs v1/v2, Event Ingest, Servers Integration, Portal Bots, integration tests), SQL admin / reader / writer groups, scoped managed identities, and a shared Key Vault for cross-cutting secrets.

This file is the brief for the **GitHub Copilot coding agent** (and any other agent that follows the [agents.md](https://agents.md) convention) when it runs in a cloud runner without the local VS Code multi-root workspace context.

> If you are a human reading this in VS Code, prefer `.github/copilot-instructions.md` for project orientation. `AGENTS.md` is the agent execution brief.

---

## Required reading (read these BEFORE doing any work)

The `copilot-setup-steps.yml` workflow checks out `frasermolyneux/.github-copilot` at `./.github-copilot/` in the runner, so the paths below resolve.

1. `.github/copilot-instructions.md` — repo-specific orientation, build commands, conventions
2. `.github-copilot/.github/instructions/personal.working-preferences.instructions.md`
3. `.github-copilot/.github/copilot-instructions.md` — org-wide catalog
4. Stack-specific files — see **Stack guardrails** below

---

## Stack guardrails

### Tenant facts (always-on)
- `.github-copilot/.github/instructions/tenant.subscriptions.instructions.md`
- `.github-copilot/.github/instructions/tenant.regions.instructions.md`
- `.github-copilot/.github/instructions/tenant.identity.instructions.md`
- `.github-copilot/.github/instructions/tenant.dns.instructions.md`

### Enforceable standards
- `.github-copilot/.github/instructions/standards.oidc-and-secrets.instructions.md` — **no client secrets**
- `.github-copilot/.github/instructions/standards.azure-naming.instructions.md`
- `.github-copilot/.github/instructions/standards.azure-tagging.instructions.md`
- `.github-copilot/.github/instructions/standards.terraform-style.instructions.md`
- `.github-copilot/.github/instructions/standards.branching-and-prs.instructions.md`

### Patterns
- `.github-copilot/.github/instructions/patterns.terraform-remote-state.instructions.md`
- `.github-copilot/.github/instructions/patterns.workload-identity-provisioning.instructions.md`
- `.github-copilot/.github/instructions/terraform.instructions.md`

### Platform consumption contracts
- `.github-copilot/.github/instructions/platform.workloads.instructions.md` — RGs / backends
- `.github-copilot/.github/instructions/platform.monitoring.instructions.md` — diagnostic settings
- `.github-copilot/.github/instructions/platform.connectivity.instructions.md` — DNS for APIM custom domains
- `.github-copilot/.github/instructions/platform.instructions.md` — catalog

---

## Build, test, format

```pwsh
terraform -chdir=terraform fmt -check -recursive
terraform -chdir=terraform init -backend-config=backends/dev.backend.hcl
terraform -chdir=terraform validate
terraform -chdir=terraform plan -var-file=tfvars/dev.tfvars
```

---

## Do NOT

- ❌ Do not `git commit`, `git push`, force-push, rebase, or branch-mutate. Work on the assigned branch only.
- ❌ Do not introduce client secrets. **All app registrations** here are consumed downstream via OIDC federation / managed identity — App Configuration / Key Vault hold any required values, retrieved at runtime.
- ❌ Do not bypass `terraform fmt`, `validate`, or the plan stage.
- ❌ Do not change resource naming/tagging — enforced by `standards.*`.
- ❌ Do not bypass Key Vault RBAC + purge-protection requirements.
- ❌ Do not add `lifecycle { ignore_changes = ... }` to secrets unless the value really is managed externally — document the reason in a comment.
- ❌ Do not edit JSON files under `terraform/app_configs/` without understanding how `locals.tf` expands them into App Config entries.
- ❌ Do not modify `.github/workflows/`, `.github/dependabot.yml`, or `version.json` unless that is the explicit task.

---

## Validation before opening PR

- [ ] `terraform fmt -check -recursive` passes
- [ ] `terraform validate` passes for the dev backend
- [ ] `terraform plan -var-file=tfvars/dev.tfvars` succeeds and the diff is intentional
- [ ] App registrations: federated credentials defined for each subject (no client secrets)
- [ ] Key Vault entries: RBAC + purge protection retained
- [ ] If App Config keys/labels were added/renamed, downstream consumers audited
- [ ] PR body cites each acceptance criterion
- [ ] Risk/rollout section filled in

---

## Escalation

If you hit any of the conditions below, **open the PR as draft** and **apply the `needs-decision` label** instead of pushing forward to ready-for-review. Post a comment on the originating issue summarising what's blocking you and what decision is needed.

Stop and escalate when:

- A change would rotate / invalidate a client secret used by a downstream workload (this should not happen — escalate).
- An app-registration audience / scope rename would force downstream contract breaks.
- A `code-review` finding is **High** and cannot be resolved in-scope.
- The Azure AD role assignments required to apply the plan are missing in the runner identity.
