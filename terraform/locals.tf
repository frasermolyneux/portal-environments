locals {
  resource_group_name    = "rg-portal-environments-${var.environment}-${var.location}"
  app_configuration_name = "appcs-portal-${var.environment}-${var.location}"

  api_management_identity_name         = "id-portal-api-management-${var.environment}"
  public_webapp_identity_name          = "id-portal-webapp-${var.environment}"
  repository_webapi_identity_name      = "id-portal-repository-webapi-${var.environment}"
  message_broker_funcapp_identity_name = "id-portal-messagebroker-funcapp-${var.environment}"
  event_ingest_funcapp_identity_name   = "id-portal-eventingest-funcapp-${var.environment}"
  sync_funcapp_identity_name           = "id-portal-sync-funcapp-${var.environment}"
  repository_funcapp_identity_name     = "id-portal-repository-funcapp-${var.environment}"

  app_registration_name = "portal-repository-${var.environment}-01"
}

locals {
  json_files = [for config in var.app_configs : jsondecode(file("app_configs/${config}.json"))]

  configs = [for content in local.json_files : {
    label = content.label,
    keys = [for key in lookup(content, "keys", []) : {
      key   = key.key,
      value = lookup(key, "value", "")
    }]
    secret_keys = [for key in lookup(content, "secret_keys", []) : {
      key        = key.key
      expiration = lookup(key, "expiration", null)
    }]
  }]

  config_keys = flatten([
    for config in local.configs : [
      for key in config.keys : {
        key      = format("%s-%s", config.label, key.key)
        label    = config.label
        key_name = key.key
        value    = key.value
      }
    ]
  ])

  config_secret_keys = flatten([
    for config in local.configs : [
      for key in config.secret_keys : {
        key        = format("%s-%s", config.label, key.key)
        label      = config.label
        key_name   = key.key
        expiration = key.expiration
      }
    ]
  ])
}
