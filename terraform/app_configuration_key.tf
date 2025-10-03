resource "azurerm_app_configuration_key" "config_keys" {
  for_each = { for each in local.config_keys : each.key => each }

  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = each.value.key_name
  label = each.value.label
  value = each.value.value
}

resource "azurerm_app_configuration_key" "config_secret_keys" {
  for_each = { for each in local.config_secret_keys : each.key => each }

  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = each.value.key_name
  label = each.value.label

  vault_key_reference = azurerm_key_vault_secret.config_secret[each.value.key].versionless_id
}
