locals {
  sync_api_service_account_identity_keys = toset([
    "web"
  ])

  sync_api_service_account_role_id = one([
    for role in azuread_application.sync_api_application.app_role : role.id
    if role.value == "ServiceAccount"
  ])
}

resource "azuread_app_role_assignment" "sync_api_service_account" {
  for_each = {
    for key, identity in local.managed_identities :
    key => identity
    if contains(local.sync_api_service_account_identity_keys, key)
  }

  app_role_id         = local.sync_api_service_account_role_id
  principal_object_id = azurerm_user_assigned_identity.managed[each.key].principal_id
  resource_object_id  = azuread_service_principal.sync_api_service_principal.object_id
}
