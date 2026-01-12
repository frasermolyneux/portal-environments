environment = "dev"
location    = "swedencentral"

subscription_id = "d68448b0-9947-46d7-8771-baa331a3063a"

platform_workloads_state = {
  resource_group_name  = "rg-tf-platform-workloads-prd-uksouth-01"
  storage_account_name = "sadz9ita659lj9xb3"
  container_name       = "tfstate"
  key                  = "terraform.tfstate"
  subscription_id      = "7760848c-794d-4a19-8cb2-52f71a21ac2b"
  tenant_id            = "e56a6947-bb9a-4a6e-846a-1f118d1c3a14"
}

sql_admin_aad_group_members = [
  "spn-portal-repository-development",
  "spn-portal-web-development"
]

app_configuration_sku = "free"

app_configs = ["repository-webapi-v1-dev", "repository-webapi-v2-dev", "repository-integration-tests-dev", "servers-integration-webapi-v1-dev", "portal-web-dev"]

tags = {
  Environment = "dev",
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
    namespaces = [
      "XtremeIdiots.Portal.Web"
    ]
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
