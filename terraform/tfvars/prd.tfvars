environment = "prd"
location    = "uksouth"

subscription_id = "32444f38-32f4-409f-889c-8e8aa2b5b4d1"

platform_workloads_state = {
  resource_group_name  = "rg-tf-platform-workloads-prd-uksouth-01"
  storage_account_name = "sadz9ita659lj9xb3"
  container_name       = "tfstate"
  key                  = "terraform.tfstate"
  subscription_id      = "7760848c-794d-4a19-8cb2-52f71a21ac2b"
  tenant_id            = "e56a6947-bb9a-4a6e-846a-1f118d1c3a14"
}

sql_admin_aad_group_members = [
  "spn-portal-repository-production",
  "spn-portal-web-production"
]

app_configuration_sku = "developer"

app_configs = ["repository-webapi-v1-prd", "repository-webapi-v2-prd", "repository-integration-tests-prd", "servers-integration-webapi-v1-prd"]

tags = {
  Environment = "prd",
  Workload    = "portal-environments",
  DeployedBy  = "GitHub-Terraform",
  Git         = "https://github.com/frasermolyneux/portal-environments"
}

managed_identities = {
  api_management = {
    namespaces = []
  }

  sql_server = {
    namespaces        = []
    app_config_reader = false
  }

  repository = {
    namespaces = [
      "XtremeIdiots.Portal.Repository.Api.V1",
      "XtremeIdiots.Portal.Repository.Api.V2"
    ]
  }

  servers_integration = {
    namespaces = [
      "XtremeIdiots.Portal.Integrations.Servers.Api.V1"
    ]
  }

  web = {
    namespaces = []
  }

  event_ingest = {
    namespaces = []
  }

  sync = {
    namespaces = []
  }

  repository_func = {
    namespaces = []
  }
}
