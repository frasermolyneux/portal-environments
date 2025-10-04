resource "azurerm_user_assigned_identity" "managed" {
  for_each = local.managed_identities

  name                = each.value.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = each.value.tags
}
