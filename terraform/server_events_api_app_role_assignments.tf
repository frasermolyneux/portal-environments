locals {
  server_events_api_service_account_role_id = one([
    for role in azuread_application.server_events_api_application.app_role : role.id
    if role.value == "ServiceAccount"
  ])
}

resource "azuread_app_role_assignment" "server_events_api_cod4x_plugin_service_account" {
  app_role_id         = local.server_events_api_service_account_role_id
  principal_object_id = azuread_service_principal.cod4x_plugin_service_principal.object_id
  resource_object_id  = azuread_service_principal.server_events_api_service_principal.object_id
}
