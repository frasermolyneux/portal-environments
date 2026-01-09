locals {
  event_ingest_api_event_generator_identity_keys = toset([
    "environments_api_management_identity",
  ])

  event_ingest_api_event_generator_role_id = one([
    for role in azuread_application.event_ingest_api_application.app_role : role.id
    if role.value == "EventGenerator"
  ])
}

resource "azuread_app_role_assignment" "event_ingest_api_event_generator" {
  for_each = {
    for key, identity in local.managed_identities :
    key => identity
    if contains(local.event_ingest_api_event_generator_identity_keys, key)
  }

  app_role_id         = local.event_ingest_api_event_generator_role_id
  principal_object_id = azurerm_user_assigned_identity.managed[each.key].principal_id
  resource_object_id  = azuread_service_principal.event_ingest_api_service_principal.object_id
}
