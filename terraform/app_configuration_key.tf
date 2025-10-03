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

// Dynamic keys from resources created in this repository
resource "azurerm_app_configuration_key" "repository_webapi_audience" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "AzureAd:Audience"
  label = "repository-webapi"
  value = format("api://%s", local.app_registration_name)
}

resource "azurerm_app_configuration_key" "repository_webapi_client_id" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "AzureAd:ClientId"
  label = "repository-webapi"

  vault_key_reference = azurerm_key_vault_secret.repository_webapi_app_client_id.versionless_id
}

resource "azurerm_app_configuration_key" "repository_webapi_client_secret" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "AzureAd:ClientSecret"
  label = "repository-webapi"

  vault_key_reference = azurerm_key_vault_secret.repository_webapi_app_password.versionless_id
}
