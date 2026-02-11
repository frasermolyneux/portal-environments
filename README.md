# portal-environments

[![Code Quality](https://github.com/frasermolyneux/portal-environments/actions/workflows/codequality.yml/badge.svg)](https://github.com/frasermolyneux/portal-environments/actions/workflows/codequality.yml)
[![PR Verify](https://github.com/frasermolyneux/portal-environments/actions/workflows/pr-verify.yml/badge.svg)](https://github.com/frasermolyneux/portal-environments/actions/workflows/pr-verify.yml)
[![Deploy Dev](https://github.com/frasermolyneux/portal-environments/actions/workflows/deploy-dev.yml/badge.svg)](https://github.com/frasermolyneux/portal-environments/actions/workflows/deploy-dev.yml)
[![Deploy Prd](https://github.com/frasermolyneux/portal-environments/actions/workflows/deploy-prd.yml/badge.svg)](https://github.com/frasermolyneux/portal-environments/actions/workflows/deploy-prd.yml)

## Documentation

- [Development Workflows](/docs/development-workflows.md) - Branch strategy, CI/CD triggers, and development flows

## Overview
Terraform-only stack that provisions portal environment assets: App Configuration with Key Vault-backed secrets, API Management, Azure AD app registrations/service principals (Repository APIs v1/v2, Event Ingest, Servers Integration, Portal Bots, integration tests), and SQL admin/reader/writer groups. State is sourced from platform-workloads remote outputs to reuse resource groups/backends, and `app_configs/*.json` files drive App Configuration/Key Vault population alongside dynamic keys for produced identities. GitHub Actions run OIDC-authenticated Terraform plans/applies for Development and Production via the reusable workflows above.

## Contributing

Please read the [contributing](CONTRIBUTING.md) guidance; this is a learning and development project.

## Security

Please read the [security](SECURITY.md) guidance; I am always open to security feedback through email or opening an issue.
