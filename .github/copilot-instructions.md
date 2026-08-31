# Copilot Instructions

- This is a Terraform-only repository; all infrastructure is in the `terraform/` root module.
- It owns environment-specific App Configuration, Key Vault secrets, API Management, Entra ID applications, managed identities, permissions, SQL groups, and role assignments.
- Terraform requires `>= 1.15.6`; use the provider constraints in `terraform/providers.tf`.
- Environment inputs are `terraform/tfvars/{dev,prd}.tfvars`; backend settings are `terraform/backends/{dev,prd}.backend.hcl`.
- The AzureRM backend and `platform-workloads` remote state use OIDC/Azure AD authentication; Google resources use workload identity in CI.
- Treat outputs, app roles/scopes, identifiers, secret names, App Configuration keys/labels, identities, and assignments as cross-repository contracts.
- `terraform/app_configs/*.json` is expanded by `locals.tf`; preserve namespace, label, key, and secret-key behavior.
- Preserve credential rotation, Key Vault lifecycle rules, RBAC, purge protection, least privilege, remote-state coordinates, and environment separation.
- Keep related application registration, service principal, permission, secret, and assignment changes consistent.
- Format checks use `terraform -chdir=terraform fmt -check -recursive`.
- Do not edit generated state, plans, `.terraform/`, or `.terraform.lock.hcl`.
