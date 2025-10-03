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
