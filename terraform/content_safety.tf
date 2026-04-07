resource "azurerm_cognitive_account" "content_safety" {
  name                  = "cs-portal-${var.environment}-${var.location}"
  location              = data.azurerm_resource_group.rg.location
  resource_group_name   = data.azurerm_resource_group.rg.name
  kind                  = "ContentSafety"
  sku_name              = "S0"
  custom_subdomain_name = "cs-portal-${var.environment}-${var.location}"

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
