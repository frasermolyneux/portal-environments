// Azure App Configuration
output "app_configuration_endpoint" {
  value = azurerm_app_configuration.app_configuration.endpoint
}

// User Assigned Identities
output "managed_identity_ids" {
  description = "Map of managed identity resource IDs keyed by identity name."
  value       = { for key, identity in azurerm_user_assigned_identity.managed : key => identity.id }
}

output "managed_identity_principal_ids" {
  description = "Map of managed identity principal IDs keyed by identity name."
  value       = { for key, identity in azurerm_user_assigned_identity.managed : key => identity.principal_id }
}
