// Event Ingest Application
resource "random_uuid" "app_role_event_ingest_generator" {
}

resource "azuread_application" "event_ingest_api_application" {
  display_name = local.event_ingest_app_registration_name
  identifier_uris = [
    format("api://%s/%s", data.azuread_client_config.current.tenant_id, local.event_ingest_app_registration_name)
  ]
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMyOrg"

  app_role {
    allowed_member_types = ["Application"]
    description          = "Event generators can create player and server events"
    display_name         = "EventGenerator"
    enabled              = true
    id                   = random_uuid.app_role_event_ingest_generator.result
    value                = "EventGenerator"
  }
}

resource "azuread_service_principal" "event_ingest_api_service_principal" {
  client_id                    = azuread_application.event_ingest_api_application.client_id
  app_role_assignment_required = false

  owners = [
    data.azuread_client_config.current.object_id
  ]
}
