resource "azuread_app_role_assignment" "portal_bots_repository_api_service_account" {
  app_role_id         = local.repository_api_service_account_role_id
  principal_object_id = azuread_service_principal.portal_bots_service_principal.object_id
  resource_object_id  = azuread_service_principal.repository_api_service_principal.object_id
}

resource "azuread_app_role_assignment" "portal_bots_event_ingest_api_event_generator" {
  app_role_id         = local.event_ingest_api_event_generator_role_id
  principal_object_id = azuread_service_principal.portal_bots_service_principal.object_id
  resource_object_id  = azuread_service_principal.event_ingest_api_service_principal.object_id
}
