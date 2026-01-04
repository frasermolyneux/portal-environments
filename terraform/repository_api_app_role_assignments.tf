locals {
  repository_api_service_account_identity_keys = toset([
    "public_webapp_identity",
    "event_ingest_funcapp_identity",
    "sync_funcapp_identity",
    "repository_funcapp_identity",
  ])
}

resource "azuread_app_role_assignment" "repository_api_service_account" {
  for_each = {
    for key, identity in local.managed_identities :
    key => identity
    if contains(local.repository_api_service_account_identity_keys, key)
  }

  app_role_id         = azuread_application.repository_api_application.app_role[0].id
  principal_object_id = azurerm_user_assigned_identity.managed[each.key].principal_id
  resource_object_id  = azuread_service_principal.repository_api_service_principal.object_id
}
