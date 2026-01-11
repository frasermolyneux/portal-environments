resource "azurerm_key_vault_secret" "config_secret" {
  for_each = { for each in local.config_secret_keys : each.key => each }

  name         = lower(replace(each.value.key_name, ":", "-"))
  value        = "placeholder"
  key_vault_id = azurerm_key_vault.config_kv[each.value.namespace].id

  content_type = "text/plain"

  expiration_date = each.value.expiration

  lifecycle {
    ignore_changes = [value]
  }
}

// Dynamic secrets from resources created in this repository
resource "azurerm_key_vault_secret" "repository_webapi_app_client_id_v1" {
  name         = "azuread-app-client-id-repository-webapi"
  value        = azuread_application.repository_api_application.client_id
  key_vault_id = azurerm_key_vault.config_kv[local.repository_webapi_namespace_v1].id

  content_type = "text/plain"
}

resource "azurerm_key_vault_secret" "repository_webapi_app_password_v1" {
  name         = "azuread-app-password-repository-webapi"
  value        = azuread_application_password.app_password_primary.value
  key_vault_id = azurerm_key_vault.config_kv[local.repository_webapi_namespace_v1].id

  content_type = "text/plain"
}

resource "azurerm_key_vault_secret" "repository_webapi_app_client_id_v2" {
  name         = "azuread-app-client-id-repository-webapi"
  value        = azuread_application.repository_api_application.client_id
  key_vault_id = azurerm_key_vault.config_kv[local.repository_webapi_namespace_v2].id

  content_type = "text/plain"
}

resource "azurerm_key_vault_secret" "repository_webapi_app_password_v2" {
  name         = "azuread-app-password-repository-webapi"
  value        = azuread_application_password.app_password_primary.value
  key_vault_id = azurerm_key_vault.config_kv[local.repository_webapi_namespace_v2].id

  content_type = "text/plain"
}

resource "azurerm_key_vault_secret" "servers_integration_app_client_id" {
  name         = "azuread-app-client-id-servers-integration"
  value        = azuread_application.servers_integration_api_application.client_id
  key_vault_id = azurerm_key_vault.config_kv[local.servers_integration_namespace].id

  content_type = "text/plain"
}

resource "azurerm_key_vault_secret" "servers_integration_app_client_secret" {
  name         = "azuread-app-password-servers-integration"
  value        = azuread_application_password.servers_integration_primary.value
  key_vault_id = azurerm_key_vault.config_kv[local.servers_integration_namespace].id

  content_type = "text/plain"
}

// Repository Integration Tests
resource "azurerm_key_vault_secret" "repository_integration_tests_app_client_id" {
  name         = "azuread-app-client-id-repository-integration-tests"
  value        = azuread_application.repository_integration_tests.client_id
  key_vault_id = azurerm_key_vault.config_kv[local.repository_integration_tests_namespace].id

  content_type = "text/plain"
}

resource "azurerm_key_vault_secret" "repository_integration_tests_app_client_secret" {
  name         = "azuread-app-password-repository-integration-tests"
  value        = azuread_application_password.repository_integration_tests_primary.value
  key_vault_id = azurerm_key_vault.config_kv[local.repository_integration_tests_namespace].id

  content_type = "text/plain"
}

resource "azurerm_key_vault_secret" "repository_integration_tests_app_tenant_id" {
  name         = "azuread-app-tenant-id-repository-integration-tests"
  value        = data.azurerm_client_config.current.tenant_id
  key_vault_id = azurerm_key_vault.config_kv[local.repository_integration_tests_namespace].id

  content_type = "text/plain"
}

resource "azurerm_key_vault_secret" "portal_bots_app_client_id" {
  name         = "azuread-app-client-id-portal-bots"
  value        = azuread_application.portal_bots_application.client_id
  key_vault_id = azurerm_key_vault.portal_bots.id

  content_type = "text/plain"
}

resource "azurerm_key_vault_secret" "portal_bots_app_client_secret" {
  name         = "azuread-app-password-portal-bots"
  value        = azuread_application_password.portal_bots_primary.value
  key_vault_id = azurerm_key_vault.portal_bots.id

  content_type = "text/plain"
}
