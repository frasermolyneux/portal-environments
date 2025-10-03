resource "azurerm_role_assignment" "api_management_identity_app_config_reader" {
  scope                = azurerm_app_configuration.app_configuration.id
  role_definition_name = "App Configuration Data Reader"
  principal_id         = azurerm_user_assigned_identity.api_management_identity.principal_id
}

resource "azurerm_role_assignment" "public_webapp_identity_app_config_reader" {
  scope                = azurerm_app_configuration.app_configuration.id
  role_definition_name = "App Configuration Data Reader"
  principal_id         = azurerm_user_assigned_identity.public_webapp_identity.principal_id
}

resource "azurerm_role_assignment" "repository_webapi_identity_app_config_reader" {
  scope                = azurerm_app_configuration.app_configuration.id
  role_definition_name = "App Configuration Data Reader"
  principal_id         = azurerm_user_assigned_identity.repository_webapi_identity.principal_id
}

resource "azurerm_role_assignment" "message_broker_funcapp_identity_app_config_reader" {
  scope                = azurerm_app_configuration.app_configuration.id
  role_definition_name = "App Configuration Data Reader"
  principal_id         = azurerm_user_assigned_identity.message_broker_funcapp_identity.principal_id
}

resource "azurerm_role_assignment" "event_ingest_funcapp_identity_app_config_reader" {
  scope                = azurerm_app_configuration.app_configuration.id
  role_definition_name = "App Configuration Data Reader"
  principal_id         = azurerm_user_assigned_identity.event_ingest_funcapp_identity.principal_id
}

resource "azurerm_role_assignment" "sync_funcapp_identity_app_config_reader" {
  scope                = azurerm_app_configuration.app_configuration.id
  role_definition_name = "App Configuration Data Reader"
  principal_id         = azurerm_user_assigned_identity.sync_funcapp_identity.principal_id
}

resource "azurerm_role_assignment" "repository_funcapp_identity_app_config_reader" {
  scope                = azurerm_app_configuration.app_configuration.id
  role_definition_name = "App Configuration Data Reader"
  principal_id         = azurerm_user_assigned_identity.repository_funcapp_identity.principal_id
}
