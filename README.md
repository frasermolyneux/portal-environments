# portal-environments

[![Build and Test](https://github.com/frasermolyneux/portal-environments/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/frasermolyneux/portal-environments/actions/workflows/build-and-test.yml)
[![Code Quality](https://github.com/frasermolyneux/portal-environments/actions/workflows/codequality.yml/badge.svg)](https://github.com/frasermolyneux/portal-environments/actions/workflows/codequality.yml)
[![Copilot Setup Steps](https://github.com/frasermolyneux/portal-environments/actions/workflows/copilot-setup-steps.yml/badge.svg)](https://github.com/frasermolyneux/portal-environments/actions/workflows/copilot-setup-steps.yml)
[![Dependabot Auto-Merge](https://github.com/frasermolyneux/portal-environments/actions/workflows/dependabot-automerge.yml/badge.svg)](https://github.com/frasermolyneux/portal-environments/actions/workflows/dependabot-automerge.yml)
[![Deploy Dev](https://github.com/frasermolyneux/portal-environments/actions/workflows/deploy-dev.yml/badge.svg)](https://github.com/frasermolyneux/portal-environments/actions/workflows/deploy-dev.yml)
[![Deploy Prd](https://github.com/frasermolyneux/portal-environments/actions/workflows/deploy-prd.yml/badge.svg)](https://github.com/frasermolyneux/portal-environments/actions/workflows/deploy-prd.yml)
[![Destroy Environment](https://github.com/frasermolyneux/portal-environments/actions/workflows/destroy-environment.yml/badge.svg)](https://github.com/frasermolyneux/portal-environments/actions/workflows/destroy-environment.yml)
[![PR Verify](https://github.com/frasermolyneux/portal-environments/actions/workflows/pr-verify.yml/badge.svg)](https://github.com/frasermolyneux/portal-environments/actions/workflows/pr-verify.yml)

## Documentation

- [Development Workflows](/docs/development-workflows.md) - Branch strategy, CI/CD triggers, and development flows

## Overview

This repository contains the Terraform configuration for provisioning portal environment infrastructure on Azure. It manages App Configuration with Key Vault-backed secrets, API Management, Azure AD app registrations and service principals (Repository APIs v1/v2, Event Ingest, Servers Integration, Portal Bots, integration tests), SQL admin/reader/writer groups, and managed identities with scoped role assignments. State is sourced from platform-workloads remote outputs to reuse resource groups and backends, while `app_configs/*.json` files drive App Configuration and Key Vault population alongside dynamic keys for identities, shared configuration (URLs, business constants, forum IDs, geo-location API), per-app settings (App Insights sampling, data retention), and cross-cutting secrets via a shared Key Vault. GitHub Actions workflows run OIDC-authenticated Terraform plans and applies for Development and Production environments.

## Contributing

Please read the [contributing](CONTRIBUTING.md) guidance; this is a learning and development project.

## Security

Please read the [security](SECURITY.md) guidance; I am always open to security feedback through email or opening an issue.

## Local dev: MCP wire-up

This repo is wired to the `frasermolyneux-copilot` MCP server (pinned to tag `v0.1.0` of [`frasermolyneux/.github-copilot`](https://github.com/frasermolyneux/.github-copilot)) so MCP-capable Copilot clients can query org conventions, instructions, prompts, and agents at runtime. The wiring lives in `.github/copilot/mcp_config.json` (consumed by the GitHub Copilot coding agent) and is built in CI by `.github/workflows/copilot-setup-steps.yml`. For the full tool surface, content-root resolution, local `.vscode/mcp.json` setup, and per-client wire-up snippets, see [`.github-copilot/mcp-server/README.md`](https://github.com/frasermolyneux/.github-copilot/blob/v0.1.0/mcp-server/README.md).
