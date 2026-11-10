# Development Workflows

Terraform-only repository for portal-environments (identities, app registrations, permissions). Branch strategy, triggers, and flows below.

## Branch Strategy & Triggers

### Feature Development (feature/*, bugfix/*, hotfix/*)
- **build-and-test.yml**: Runs on push to feature branches
  - Executes Terraform plan for Development
  - No apply or production steps

### Pull Requests → main
- **pr-verify.yml**: Validation pipeline (runs on PR open/updates/reopen/ready for review)
  - Full Dev Terraform plan runs unless `deploy-dev` is present (including copilot/* and dependabot PRs)
  - `deploy-dev` selects Dev plan/apply for non-dependabot PRs; removing it runs a fresh Dev plan
  - Full Prd Terraform plan requires `run-prd-plan`; adding the label also starts the plan
  - Draft PRs are skipped; unrelated label changes do not start state-backed operations
  - Concurrency groups serialize dev/prd operations without cancelling in-progress runs

### Main Branch (on merge)
- **deploy-prd.yml**: Promotion pipeline
  - Dev plan/apply → Prd plan/apply
  - Triggers: push to `main` changing `terraform/**` (including Maps integration) or this workflow, manual dispatch
  - Weekly schedule (Wednesday 1am UTC) runs Prd only
  - All plans are untargeted; applies use the saved plan
  - Workflow-level concurrency prevents overlapping runs

### On-Demand
- **deploy-dev.yml**: Manual dispatch to refresh Development (plan+apply)
- **devops-secure-scanning.yml**: Security scanning per repo schedule

### Native Portal map downloads

The `web` consumer in `maps_api_integration.tf` grants the existing Portal web
managed identity only `Maps.Read` and installs `RedirectApi:BaseUrl` and
`RedirectApi:ApplicationAudience` in `XtremeIdiots.Portal.Web` for each
environment. The `sync` and `servers_integration` consumers retain their own
`Maps.Read` bindings and `RedirectApi` configuration. Changes follow the normal
full PR plans and Development-to-Production promotion; no bootstrap label,
targeted deployment scope, or workflow-disable procedure is needed.

This assignment does not grant user impersonation or administration by itself.
The Maps workload must separately allowlist the exact Portal principal IDs and
HTTPS browser origins for its read-only delegation/download contract. Deploy
that contract before deploying the Portal UI. Portal derives forum identity
from its existing authenticated session; anonymous users retain anonymous
quotas. File and ZIP bytes travel directly from Maps, not through App Service.

## Standard Developer Flow

```bash
terraform -chdir=terraform init -lockfile=readonly -backend-config=backends/dev.backend.hcl
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
- Prd plan is opt-in via `run-prd-plan`; Dev plans run on non-draft PRs unless `deploy-dev` selects Dev plan/apply (non-dependabot only)

## Quick Reference

| Scenario           | Workflow       | Trigger                | Terraform     | Deploy |
| ------------------ | -------------- | ---------------------- | ------------- | ------ |
| Feature commit     | build-and-test | Push to feature/*      | Dev plan      | ❌      |
| PR validation      | pr-verify      | PR to main             | Dev plan      | ❌      |
| Infrastructure merge | deploy-prd   | Terraform/workflow push to main | Dev+Prd apply | ✅ |
| Weekly production refresh | deploy-prd | Wed 1am UTC         | Prd apply     | ✅      |
| Manual dev refresh | deploy-dev     | Manual dispatch        | Dev apply     | ✅      |

## Environment Variables

Defined in GitHub environments:
- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`
