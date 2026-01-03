// Azure App Configuration (shared across workloads)
output "app_configuration" {
  description = "App Configuration endpoint and identifiers."
  value = {
    name                = azurerm_app_configuration.app_configuration.name
    id                  = azurerm_app_configuration.app_configuration.id
    endpoint            = azurerm_app_configuration.app_configuration.endpoint
    resource_group_name = azurerm_app_configuration.app_configuration.resource_group_name
    location            = azurerm_app_configuration.app_configuration.location
  }
}

// User Assigned Identities keyed by workload/environment
output "managed_identities" {
  description = "Managed identities with id, client_id, and principal_id keyed by identity name."
  value = {
    for key, identity in azurerm_user_assigned_identity.managed :
    key => {
      id           = identity.id
      client_id    = identity.client_id
      principal_id = identity.principal_id
    }
  }
}

output "sql_admin_group" {
  description = "Details for the SQL administrator Azure AD group."
  value = {
    display_name = azuread_group.sql_admin_group.display_name
    object_id    = azuread_group.sql_admin_group.object_id
  }
}
