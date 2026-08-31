# AGENTS.md — portal-environments

## Purpose and ownership

Terraform-only repository for environment-specific portal identity and configuration infrastructure. It owns App Configuration, Key Vaults and secrets, API Management, Entra ID applications and service principals, managed identities, Microsoft Graph/API permissions, SQL groups, and role assignments used across portal workloads.

## Important paths

- `terraform/` — the single Terraform root module
- `terraform/providers.tf` — Terraform/provider constraints and AzureRM backend declaration
- `terraform/remote_state.tf` — upstream `platform-workloads` state
- `terraform/outputs.tf` — cross-repository identity, endpoint, and configuration contracts
- `terraform/app_configs/` — JSON inputs expanded into App Configuration keys and Key Vault secrets
- `terraform/application_registration.*.tf` — API applications, roles, scopes, credentials, and service principals
- `terraform/*role_assignments.tf` and `terraform/managed_identity_graph_permissions.tf` — Azure and Microsoft Graph authorization
- `terraform/backends/{dev,prd}.backend.hcl` — environment backend configuration
- `terraform/tfvars/{dev,prd}.tfvars` — environment identities, consumers, configuration, and inputs
- `.github/workflows/` — plan, deployment, and teardown automation

## Useful commands

```pwsh
terraform -chdir=terraform fmt -check -recursive
terraform -chdir=terraform init -backend-config=backends/dev.backend.hcl
terraform -chdir=terraform validate
terraform -chdir=terraform plan -var-file=tfvars/dev.tfvars
```

Run `init`, `validate`, or `plan` only when the task needs backend/provider evaluation and the required Azure OIDC and Google workload-identity environments are available.

## State and environment constraints

- Terraform requires `>= 1.15.6`; provider constraints are defined in `terraform/providers.tf`.
- The AzureRM backend uses OIDC/Azure AD authentication. Google resources authenticate through workload identity in CI.
- Dev and production have separate backend, tfvars, and application-configuration JSON inputs.
- Resource groups and administrative-unit/backend metadata come from `platform-workloads` remote state.
- Outputs, application identifiers, API roles/scopes, App Configuration keys/labels, Key Vault secret names, managed-identity names, and role assignments are cross-repository contracts. Coordinate any change with every consumer.
- Some application credentials and generated API keys are deliberately created here and stored in Key Vault; preserve rotation and lifecycle behavior.
- Preserve Key Vault RBAC and purge protection, least-privilege role assignments, remote-state coordinates, and environment boundaries.
- Changes to `terraform/app_configs/*.json` alter the keys expanded by `locals.tf`; assess affected namespaces and consumers.
- `.terraform.lock.hcl`, local state, plans, and `.terraform/` directories are generated and ignored.

## Authoritative repository docs

- [README.md](README.md)
- [Development workflows](docs/development-workflows.md)
- [Contributing](CONTRIBUTING.md)
- [Security](SECURITY.md)
