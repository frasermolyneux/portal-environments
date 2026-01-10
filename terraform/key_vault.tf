resource "random_id" "config_id" {
  for_each = { for each in local.configs : each.namespace => each }

  byte_length = 6
}

resource "azurerm_key_vault" "config_kv" {
  for_each = { for each in local.configs : each.namespace => each }

  name = local.key_vault_names[each.key]

  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  tenant_id = data.azurerm_client_config.current.tenant_id

  tags = merge(var.tags, {
    label     = each.value.label
    namespace = each.value.namespace
  })

  soft_delete_retention_days = 90
  purge_protection_enabled   = true
  rbac_authorization_enabled = true

  sku_name = "standard"

  network_acls {
    bypass         = "AzureServices"
    default_action = "Allow"
  }
}

resource "azurerm_key_vault" "portal_bots" {
  name                = local.portal_bots_key_vault_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  tags = var.tags

  soft_delete_retention_days = 90
  purge_protection_enabled   = true
  rbac_authorization_enabled = true

  sku_name = "standard"

  network_acls {
    bypass         = "AzureServices"
    default_action = "Allow"
  }
}
