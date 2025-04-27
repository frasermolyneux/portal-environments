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
}
