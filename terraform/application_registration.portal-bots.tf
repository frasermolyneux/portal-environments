resource "azuread_application" "portal_bots_application" {
  display_name     = local.portal_bots_app_registration_name
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMyOrg"
}

resource "azuread_service_principal" "portal_bots_service_principal" {
  client_id                    = azuread_application.portal_bots_application.client_id
  app_role_assignment_required = false

  owners = [
    data.azuread_client_config.current.object_id
  ]
}

resource "azuread_application_password" "portal_bots_primary" {
  application_id = azuread_application.portal_bots_application.id

  rotate_when_changed = {
    rotation = time_rotating.thirty_days.id
  }
}
