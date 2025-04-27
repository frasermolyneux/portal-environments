resource "azurerm_user_assigned_identity" "api_management_identity" {
  name = local.api_management_identity_name

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_user_assigned_identity" "public_webapp_identity" {
  name = local.public_webapp_identity_name

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_user_assigned_identity" "repository_webapi_identity" {
  name = local.repository_webapi_identity_name

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_user_assigned_identity" "message_broker_funcapp_identity" {
  name = local.message_broker_funcapp_identity_name

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_user_assigned_identity" "event_ingest_funcapp_identity" {
  name = local.event_ingest_funcapp_identity_name

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_user_assigned_identity" "sync_funcapp_identity" {
  name = local.sync_funcapp_identity_name

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_user_assigned_identity" "repository_funcapp_identity" {
  name = local.repository_funcapp_identity_name

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
