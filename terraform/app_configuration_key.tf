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
// Repository Web API V1
resource "azurerm_app_configuration_key" "repository_webapi_audience_v1" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "AzureAd:Audience"
  label = "repository-webapi-v1"
  value = format("api://%s", local.app_registration_name)
}

resource "azurerm_app_configuration_key" "repository_webapi_client_id_v1" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "AzureAd:ClientId"
  label = "repository-webapi-v1"

  vault_key_reference = azurerm_key_vault_secret.repository_webapi_app_client_id_v1.versionless_id
}

resource "azurerm_app_configuration_key" "repository_webapi_client_secret_v1" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "AzureAd:ClientSecret"
  label = "repository-webapi-v1"

  vault_key_reference = azurerm_key_vault_secret.repository_webapi_app_password_v1.versionless_id
}

// Repository Web API V2
resource "azurerm_app_configuration_key" "repository_webapi_audience_v2" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "AzureAd:Audience"
  label = "repository-webapi-v2"
  value = format("api://%s", local.app_registration_name)
}

resource "azurerm_app_configuration_key" "repository_webapi_client_id_v2" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "AzureAd:ClientId"
  label = "repository-webapi-v2"

  vault_key_reference = azurerm_key_vault_secret.repository_webapi_app_client_id_v2.versionless_id
}

resource "azurerm_app_configuration_key" "repository_webapi_client_secret_v2" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "AzureAd:ClientSecret"
  label = "repository-webapi-v2"

  vault_key_reference = azurerm_key_vault_secret.repository_webapi_app_password_v2.versionless_id
}

// Repository Integration Tests
resource "azurerm_app_configuration_key" "repository_integration_tests_client_id" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "AzureAd:ClientId"
  label = "repository-integration-tests"

  vault_key_reference = azurerm_key_vault_secret.repository_integration_tests_app_client_id.versionless_id
}

resource "azurerm_app_configuration_key" "repository_integration_tests_client_secret" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "AzureAd:ClientSecret"
  label = "repository-integration-tests"

  vault_key_reference = azurerm_key_vault_secret.repository_integration_tests_app_client_secret.versionless_id
}
