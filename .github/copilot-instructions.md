# Copilot Instructions

> Shared conventions: see [`.github-copilot/.github/instructions/terraform.instructions.md`](../../.github-copilot/.github/instructions/terraform.instructions.md) for the standard Terraform layout, providers, remote-state pattern, validation commands, and CI/CD workflows.

## Project Overview

Terraform-only repository that provisions portal environment infrastructure on Azure: App Configuration with Key Vault-backed secrets, API Management (consumption tier), Azure AD app registrations/service principals (Repository APIs v1/v2, Event Ingest, Servers Integration, Portal Bots, integration tests), SQL admin/reader/writer groups, managed identities with scoped role assignments, and a shared Key Vault for cross-cutting secrets.

## Technology Stack

- **Infrastructure**: Terraform >= 1.14.3 with azurerm ~> 4.59, azuread ~> 3.0, random ~> 3.8
- **Cloud**: Microsoft Azure (App Configuration, Key Vault, API Management, Azure AD, Managed Identities)
- **CI/CD**: GitHub Actions with OIDC authentication to Azure
- **State**: Remote state in Azure Storage; depends on platform-workloads remote state for resource groups/backends

## Repository Structure

- `terraform/` — All Terraform configuration files (root module)
- `terraform/app_configs/` — JSON files driving App Configuration and Key Vault entries
- `terraform/backends/` — Backend configuration files (dev.backend.hcl, prd.backend.hcl)
- `terraform/tfvars/` — Variable files per environment (dev.tfvars, prd.tfvars)
- `.github/workflows/` — CI/CD workflow definitions
- `docs/` — Project documentation

## Key Patterns

- Resource names combine workload/environment/location with random IDs (e.g., `apim-portal-{env}-{location}-{rand}`)
- `app_configs/*.json` drives config creation with label, namespace, keys, and secret_keys
- `locals.tf` expands JSON configs into `config_keys`/`config_secret_keys` for App Configuration entries
- Key Vault names use random IDs to satisfy Azure naming length limits
- `application_registration.*.tf` files create app registrations with ServiceAccount roles and rotating passwords
- `app_configuration_key.tf` defines dynamic keys beyond JSON-driven configs: shared URLs, business constants (forum IDs, defaults), geo-location API, Google config, per-app App Insights sampling, SQL resilience, and data retention
- A shared Key Vault (`azurerm_key_vault.shared`) stores cross-cutting secrets (forums API key, map redirect API key) with RBAC for all managed identities
- `role_assignments.tf` grants App Configuration Data Reader and Key Vault Secrets User per namespace, Key Vault Secrets User on the shared KV for all managed identities, and Cognitive Services User for content safety
- The `geo_location_api` variable defines per-consumer Key Vault references with app-scoped App Config prefixes
- Resource groups are resolved from platform-workloads remote state, not created here

## Workflow Summary

- **build-and-test**: Runs Terraform plan for Dev on feature branch pushes
- **pr-verify**: Validates PRs with Dev plan; Prd plan requires `run-prd-plan` label
- **deploy-dev**: Manual dispatch for Dev plan+apply
- **deploy-prd**: Triggered on main push, weekly schedule, or manual dispatch; applies Dev then Prd
- **codequality**: Scheduled code quality scanning
- **dependabot-automerge**: Auto-merges Dependabot PRs
- **destroy-environment**: Manual environment teardown

## Local Development

```bash
terraform -chdir=terraform init -backend-config=backends/dev.backend.hcl
terraform -chdir=terraform plan -var-file=tfvars/dev.tfvars
```

## Coding Guidelines

- Follow HashiCorp Terraform style conventions
- Use `terraform fmt` before committing
- Keep resource definitions in logically grouped files (e.g., one file per app registration)
- Use `ignore_changes` lifecycle rules for secrets that are managed externally after initial creation
- All Key Vaults must use RBAC authorization with purge protection enabled
- Provide descriptive variable descriptions and use sensible defaults where appropriate
