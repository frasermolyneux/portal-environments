resource "azurerm_storage_account" "api_spec" {
  name = local.spec_storage_account_name

  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = false

  min_tls_version = "TLS1_2"

  tags = var.tags
}

resource "azurerm_storage_container" "api_spec" {
  for_each = toset(local.spec_storage_containers)

  name                  = each.value
  storage_account_id    = azurerm_storage_account.api_spec.id
  container_access_type = "private"
}

resource "azurerm_role_assignment" "api_spec_publishers" {
  for_each = local.spec_publisher_principal_ids

  scope                = azurerm_storage_account.api_spec.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = each.value
}
