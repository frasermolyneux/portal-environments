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

  key   = "${local.repository_webapi_namespace_v1}:AzureAd:Audience"
  label = var.environment
  value = format("api://%s/%s", data.azuread_client_config.current.tenant_id, local.app_registration_name)
}

resource "azurerm_app_configuration_key" "repository_webapi_client_id_v1" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "${local.repository_webapi_namespace_v1}:AzureAd:ClientId"
  label = var.environment

  vault_key_reference = azurerm_key_vault_secret.repository_webapi_app_client_id_v1.versionless_id
}

resource "azurerm_app_configuration_key" "repository_webapi_client_secret_v1" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "${local.repository_webapi_namespace_v1}:AzureAd:ClientSecret"
  label = var.environment

  vault_key_reference = azurerm_key_vault_secret.repository_webapi_app_password_v1.versionless_id
}

// Repository Web API V2
resource "azurerm_app_configuration_key" "repository_webapi_audience_v2" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "${local.repository_webapi_namespace_v2}:AzureAd:Audience"
  label = var.environment
  value = format("api://%s/%s", data.azuread_client_config.current.tenant_id, local.app_registration_name)
}

resource "azurerm_app_configuration_key" "repository_webapi_client_id_v2" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "${local.repository_webapi_namespace_v2}:AzureAd:ClientId"
  label = var.environment

  vault_key_reference = azurerm_key_vault_secret.repository_webapi_app_client_id_v2.versionless_id
}

resource "azurerm_app_configuration_key" "repository_webapi_client_secret_v2" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "${local.repository_webapi_namespace_v2}:AzureAd:ClientSecret"
  label = var.environment

  vault_key_reference = azurerm_key_vault_secret.repository_webapi_app_password_v2.versionless_id
}

// Servers Integration API
resource "azurerm_app_configuration_key" "servers_integration_audience" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "${local.servers_integration_namespace}:AzureAd:Audience"
  label = var.environment
  value = format("api://%s/%s", data.azuread_client_config.current.tenant_id, local.servers_integration_app_registration_name)
}

resource "azurerm_app_configuration_key" "servers_integration_client_id" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "${local.servers_integration_namespace}:AzureAd:ClientId"
  label = var.environment

  vault_key_reference = azurerm_key_vault_secret.servers_integration_app_client_id.versionless_id
}

resource "azurerm_app_configuration_key" "servers_integration_client_secret" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "${local.servers_integration_namespace}:AzureAd:ClientSecret"
  label = var.environment

  vault_key_reference = azurerm_key_vault_secret.servers_integration_app_client_secret.versionless_id
}

// Repository Integration Tests
resource "azurerm_app_configuration_key" "repository_integration_tests_client_id" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "${local.repository_integration_tests_namespace}:AzureAd:ClientId"
  label = var.environment

  vault_key_reference = azurerm_key_vault_secret.repository_integration_tests_app_client_id.versionless_id
}

resource "azurerm_app_configuration_key" "repository_integration_tests_client_secret" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "${local.repository_integration_tests_namespace}:AzureAd:ClientSecret"
  label = var.environment

  vault_key_reference = azurerm_key_vault_secret.repository_integration_tests_app_client_secret.versionless_id
}
