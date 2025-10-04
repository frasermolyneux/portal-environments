// Azure App Configuration
output "app_configuration_endpoint" {
  value = azurerm_app_configuration.app_configuration.endpoint
}

// User Assigned Identities
output "api_management_identity_id" {
  value = azurerm_user_assigned_identity.api_management_identity.id
}

output "public_webapp_identity_id" {
  value = azurerm_user_assigned_identity.public_webapp_identity.id
}

output "repository_webapi_identity_id" {
  value = azurerm_user_assigned_identity.repository_webapi_identity.id
}

output "message_broker_funcapp_identity_id" {
  value = azurerm_user_assigned_identity.message_broker_funcapp_identity.id
}

output "event_ingest_funcapp_identity_id" {
  value = azurerm_user_assigned_identity.event_ingest_funcapp_identity.id
}

output "sync_funcapp_identity_id" {
  value = azurerm_user_assigned_identity.sync_funcapp_identity.id
}

output "repository_funcapp_identity_id" {
  value = azurerm_user_assigned_identity.repository_funcapp_identity.id
}

output "api_management_identity_principal_id" {
  value = azurerm_user_assigned_identity.api_management_identity.principal_id
}

output "public_webapp_identity_principal_id" {
  value = azurerm_user_assigned_identity.public_webapp_identity.principal_id
}

output "repository_webapi_identity_principal_id" {
  value = azurerm_user_assigned_identity.repository_webapi_identity.principal_id
}

output "message_broker_funcapp_identity_principal_id" {
  value = azurerm_user_assigned_identity.message_broker_funcapp_identity.principal_id
}

output "event_ingest_funcapp_identity_principal_id" {
  value = azurerm_user_assigned_identity.event_ingest_funcapp_identity.principal_id
}

output "sync_funcapp_identity_principal_id" {
  value = azurerm_user_assigned_identity.sync_funcapp_identity.principal_id
}

output "repository_funcapp_identity_principal_id" {
  value = azurerm_user_assigned_identity.repository_funcapp_identity.principal_id
}
