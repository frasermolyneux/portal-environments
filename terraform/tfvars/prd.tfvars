environment = "prd"
location    = "uksouth"

subscription_id = "32444f38-32f4-409f-889c-8e8aa2b5b4d1"

sql_admin_aad_group_members = [
  "spn-portal-repository-production",
  "spn-xtremeidiots-portal-production"
]

log_analytics_subscription_id     = "d68448b0-9947-46d7-8771-baa331a3063a"
log_analytics_resource_group_name = "rg-platform-logging-prd-uksouth-01"
log_analytics_workspace_name      = "log-platform-prd-uksouth-01"

app_configuration_sku = "developer"

app_configs = ["repository-webapi-v1-prd", "repository-webapi-v2-prd", "repository-integration-tests-prd"]

tags = {
  Environment = "prd",
  Workload    = "portal-environments",
  DeployedBy  = "GitHub-Terraform",
  Git         = "https://github.com/frasermolyneux/portal-environments"
}

managed_identities = {
  api_management_identity = {
    name_suffix = "api-management"
    namespaces  = []
  }

  public_webapp_identity = {
    name_suffix = "webapp"
    namespaces  = []
  }

  repository_webapi_identity = {
    name_suffix = "repository-webapi"
    namespaces = [
      "XtremeIdiots.Portal.Repository.Api.V1",
      "XtremeIdiots.Portal.Repository.Api.V2"
    ]
  }

  message_broker_funcapp_identity = {
    name_suffix = "messagebroker-funcapp"
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
