resource "azurerm_key_vault_secret" "config_secret" {
  for_each = { for each in local.config_secret_keys : each.key => each }

  name         = lower(replace(each.value.key_name, ":", "-"))
  value        = "placeholder"
  key_vault_id = azurerm_key_vault.config_kv[each.value.label].id

  content_type = "text/plain"

  expiration_date = each.value.expiration

  lifecycle {
    ignore_changes = [value]
  }
}

// Dynamic secrets from resources created in this repository
resource "azurerm_key_vault_secret" "repository_webapi_app_client_id" {
  name         = "azuread-app-client-id-repository-webapi"
  value        = azuread_application.repository_api_application.application_id
  key_vault_id = azurerm_key_vault.config_kv["repository-webapi"].id

  content_type = "text/plain"
}

resource "azurerm_key_vault_secret" "repository_webapi_app_password" {
  name         = "azuread-app-password-repository-webapi"
  value        = azuread_application_password.app_password_primary.value
  key_vault_id = azurerm_key_vault.config_kv["repository-webapi"].id

  content_type = "text/plain"
}
