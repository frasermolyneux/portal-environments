// Servers Integration API Application
resource "random_uuid" "app_role_servers_integration_service_account" {
}

resource "azuread_application" "servers_integration_api_application" {
  display_name = local.servers_integration_app_registration_name

  identifier_uris = [
    format("api://%s/%s", data.azuread_client_config.current.tenant_id, local.servers_integration_app_registration_name)
  ]

  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMyOrg"

  app_role {
    allowed_member_types = ["Application"]
    description          = "Service Accounts can access/manage all data aspects"
    display_name         = "ServiceAccount"
    enabled              = true
    id                   = random_uuid.app_role_servers_integration_service_account.result
    value                = "ServiceAccount"
  }
}

resource "azuread_service_principal" "servers_integration_api_service_principal" {
  client_id                    = azuread_application.servers_integration_api_application.client_id
  app_role_assignment_required = false

  owners = [
    data.azuread_client_config.current.object_id
  ]
}
