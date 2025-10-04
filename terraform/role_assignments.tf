resource "azurerm_role_assignment" "managed_identity_app_config_reader" {
  for_each = {
    for key, identity in local.managed_identities :
    key => identity
    if identity.app_config_reader
  }

  scope                = azurerm_app_configuration.app_configuration.id
  role_definition_name = "App Configuration Data Reader"
  principal_id         = azurerm_user_assigned_identity.managed[each.key].principal_id
}

resource "azurerm_role_assignment" "managed_identity_key_vault_reader" {
  for_each = {
    for pair in local.managed_identity_namespace_pairs :
    "${pair.identity_key}|${pair.namespace}" => pair
    if contains(keys(azurerm_key_vault.config_kv), pair.namespace)
  }

  scope                = azurerm_key_vault.config_kv[each.value.namespace].id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.managed[each.value.identity_key].principal_id
}
