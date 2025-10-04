environment = "dev"
location    = "uksouth"

subscription_id = "d68448b0-9947-46d7-8771-baa331a3063a"

log_analytics_subscription_id     = "d68448b0-9947-46d7-8771-baa331a3063a"
log_analytics_resource_group_name = "rg-platform-logging-prd-uksouth-01"
log_analytics_workspace_name      = "log-platform-prd-uksouth-01"

app_configuration_sku = "free"

app_configs = ["repository-webapi-v1-dev", "repository-webapi-v2-dev", "repository-integration-tests-dev"]

tags = {
  Environment = "dev",
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
