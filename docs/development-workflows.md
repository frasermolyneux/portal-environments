# Development Workflows

Terraform-only repository for portal-environments (identities, app registrations, permissions). Branch strategy, triggers, and flows below.

## Branch Strategy & Triggers

### Feature Development (feature/*, bugfix/*, hotfix/*)
- **build-and-test.yml**: Runs on push to feature branches
  - Executes Terraform plan for Development
  - No apply or production steps

### Pull Requests → main
- **pr-verify.yml**: Validation pipeline (runs on PR open/updates/reopen/ready for review)
  - Dev Terraform plan always runs (copilot/* included; dependabot skipped)
  - Prd Terraform plan requires `run-prd-plan` label
  - Concurrency groups serialize dev/prd operations

### Main Branch (on merge)
- **deploy-prd.yml**: Promotion pipeline
  - Dev plan/apply → Prd plan/apply
  - Triggers: push to `main`, weekly schedule (Thursday 3am UTC), manual dispatch
  - Workflow-level concurrency prevents overlapping runs

### On-Demand
- **deploy-dev.yml**: Manual dispatch to refresh Development (plan+apply)
- **devops-secure-scanning.yml**: Security scanning per repo schedule

### Isolated maps integration bootstrap

The initial maps integration must not reconcile unrelated live APIM drift.
Changes only to `terraform/maps_api_integration.tf` therefore do not trigger
automatic deployment. Workflow-only changes also require manual dispatch.
Other Terraform changes and scheduled full deployments retain their existing
behavior; this exception does not suppress or adopt APIM drift.

For this bootstrap, label the PR `maps-bootstrap` and `run-prd-plan`. PR plans
target only the maps role assignments, maps configuration keys, and refresh
sentinel, including their Terraform dependencies. Inspect both environment
plans: expect six additions, one sentinel update, and no APIM changes or
deletions. Adding or removing `maps-bootstrap` regenerates the affected PR
plans without interrupting an active state-backed run. Feature-branch plans
remain full, read-only drift reports.

After merging, manually dispatch **Deploy Prd** on `main` with
`scope=maps-bootstrap`. The existing saved-plan apply and environment
concurrency remain in force, promoting Development before Production. Do not
use this bootstrap scope for other infrastructure changes; ordinary manual
runs default to `scope=full`. Targets are supplied through `TF_CLI_ARGS_plan`,
never to the saved-plan apply.

## Standard Developer Flow

```bash
terraform -chdir=terraform init -backend-config=backends/dev.backend.hcl
terraform -chdir=terraform plan -var-file=tfvars/dev.tfvars
```

### Feature Branch → PR → Merge Flow

```mermaid
graph TD
    A[Create feature branch] --> B[Commit changes]
    B --> C{Push to feature/*}
    C --> D[build-and-test (Dev plan)]
    D --> E[Open PR to main]
    E --> F[pr-verify triggers]
    F --> G[Dev TF Plan]
    G --> H{Add run-prd-plan label?}
    H -->|Yes| I[Prd TF Plan]
    H -->|No| J[Review & Approve]
    I --> J
    J --> K[Merge PR]
    K --> L[deploy-prd triggers]
    L --> M[Dev Apply]
    M --> N[Prd Apply]
    
    style D fill:#e1f5ff
    style F fill:#e1f5ff
    style L fill:#ffe1e1
    style M fill:#90EE90
    style N fill:#FFB6C1
```

### Infrastructure Notes
- OIDC auth with GitHub environment variables: `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`
- Concurrency groups: `${{ github.repository }}-dev` and `${{ github.repository }}-prd`
- Prd plan is opt-in via `run-prd-plan`; dev plan always runs on PRs (except dependabot)

## Quick Reference

| Scenario           | Workflow       | Trigger                | Terraform     | Deploy |
| ------------------ | -------------- | ---------------------- | ------------- | ------ |
| Feature commit     | build-and-test | Push to feature/*      | Dev plan      | ❌      |
| PR validation      | pr-verify      | PR to main             | Dev plan      | ❌      |
| Merge to main      | deploy-prd     | Push to main / Thu 3am | Dev+Prd apply | ✅      |
| Manual dev refresh | deploy-dev     | Manual dispatch        | Dev apply     | ✅      |

## Environment Variables

Defined in GitHub environments:
- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`
