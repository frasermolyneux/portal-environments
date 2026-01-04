data "azuread_service_principal" "msgraph" {
  display_name = "Microsoft Graph"
}

locals {
  core_sql_server_identity_key = "core_sql_server_identity"

  portal_core_sql_server_graph_app_roles = [
    "User.Read.All",
    "GroupMember.Read.All",
    "Application.Read.All",
  ]

  microsoft_graph_app_roles = {
    for role in data.azuread_service_principal.msgraph.app_roles :
    role.value => role
    if role.value != null && contains(role.allowed_member_types, "Application")
  }
}

resource "azuread_app_role_assignment" "portal_core_sql_server_graph" {
  for_each = toset(local.portal_core_sql_server_graph_app_roles)

  app_role_id         = local.microsoft_graph_app_roles[each.value].id
  principal_object_id = azurerm_user_assigned_identity.managed[local.core_sql_server_identity_key].principal_id
  resource_object_id  = data.azuread_service_principal.msgraph.object_id
}
