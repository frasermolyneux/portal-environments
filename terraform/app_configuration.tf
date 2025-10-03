resource "azurerm_app_configuration" "app_configuration" {
  name = local.app_configuration_name

  sku = var.app_configuration_sku

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  purge_protection_enabled             = false
  data_plane_proxy_authentication_mode = "Pass-through"

  local_auth_enabled = false

  tags = var.tags
}

resource "azurerm_role_assignment" "deploy_sp_app_config_data_owner" {
  scope                = azurerm_app_configuration.app_configuration.id
  role_definition_name = "App Configuration Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
  principal_type       = "ServicePrincipal"
}
