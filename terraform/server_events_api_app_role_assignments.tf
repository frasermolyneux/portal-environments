locals {
  server_events_api_service_account_identity_keys = toset([
    "api_management"
  ])

  server_events_api_service_account_role_id = one([
    for role in azuread_application.server_events_api_application.app_role : role.id
    if role.value == "ServiceAccount"
  ])
}

resource "azuread_app_role_assignment" "server_events_api_service_account" {
  for_each = {
    for key, identity in local.managed_identities :
    key => identity
    if contains(local.server_events_api_service_account_identity_keys, key)
  }

  app_role_id         = local.server_events_api_service_account_role_id
  principal_object_id = azurerm_user_assigned_identity.managed[each.key].principal_id
  resource_object_id  = azuread_service_principal.server_events_api_service_principal.object_id
}
