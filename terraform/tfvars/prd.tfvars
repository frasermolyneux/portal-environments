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
  "spn-xtremeidiots-portal-production"
]

app_configuration_sku = "developer"

app_configs = ["repository-webapi-v1-prd", "repository-webapi-v2-prd", "repository-integration-tests-prd"]

tags = {
  Environment = "prd",
  Workload    = "portal-environments",
  DeployedBy  = "GitHub-Terraform",
  Git         = "https://github.com/frasermolyneux/portal-environments"
}

managed_identities = {
  core_api_management_identity = {
    name_suffix = "api-management"
    namespaces  = []
  }

  core_sql_server_identity = {
    name_suffix       = "sql-server"
    namespaces        = []
    app_config_reader = false
  }

  repository_webapi_identity = {
    name_suffix = "repository-webapi"
    namespaces = [
      "XtremeIdiots.Portal.Repository.Api.V1",
      "XtremeIdiots.Portal.Repository.Api.V2"
    ]
  }

  servers_integration_webapi_identity = {
    name_suffix = "servers-integration-webapi"
    namespaces = [
      "XtremeIdiots.Portal.Integrations.Servers.Api.V1"
    ]
  }

  public_webapp_identity = {
    name_suffix = "webapp"
    namespaces  = []
  }

  event_ingest_funcapp_identity = {
    name_suffix = "eventingest-funcapp"
    namespaces  = []
  }

  sync_funcapp_identity = {
    name_suffix = "sync-funcapp"
    namespaces  = []
  }

  repository_funcapp_identity = {
    name_suffix = "repository-funcapp"
    namespaces  = []
  }
}
